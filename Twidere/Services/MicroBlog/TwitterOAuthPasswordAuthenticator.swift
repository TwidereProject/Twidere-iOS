//
//  TwitterOAuthPasswordAuthenticator.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Kanna

class TwitterOAuthPasswordAuthenticator {
    
    let oauth: OAuthService
    let rest: RestClient
    let loginVerificationCallback: ((challangeType: String) -> String?)
    let browserUserAgent: String?
    
    init(endpoint: Endpoint, consumerKey:String, consumerSecret: String, loginVerificationCallback: ((challangeType: String) -> String?), browserUserAgent: String? = nil) {
        self.oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(consumerKey, consumerSecret))
        self.rest = RestClient(endpoint: endpoint)
        self.loginVerificationCallback = loginVerificationCallback
        self.browserUserAgent = browserUserAgent
    }
    
    func getOAuthAccessToken(username: String, password: String) throws -> OAuthToken {
        do {
            let requestToken: OAuthToken
            do {
                requestToken = try oauth.getRequestToken(ServiceConstants.oauthCallbackOob)
            } catch RestError.RequestError(_) {
                throw AuthenticationError.RequestTokenFailed
            }

            let authorizeRequestData = try getAuthorizeRequestData(requestToken)
            var authorizeResponseData = try getAuthorizeResponseData(requestToken, authorizeRequestData: authorizeRequestData, username: username, password: password)
            if (!(authorizeResponseData.oauthPin?.isEmpty ?? true)) {
                do {
                    return try oauth.getAccessToken(requestToken, oauthVerifier: authorizeResponseData.oauthPin)
                } catch RestError.RequestError(_) {
                    throw AuthenticationError.AccessTokenFailed
                }
            } else if (authorizeResponseData.challenge == nil) {
                throw AuthenticationError.WrongUsernamePassword
            }
        
            // Go to password verification flow
            let challengeType = authorizeResponseData.challenge!.challengeType
            if (challengeType == nil) {
                throw AuthenticationError.VerificationFailed
            }
            let loginVerification = loginVerificationCallback(challangeType: challengeType!)
            let verificationData = try getVerificationData(authorizeResponseData,
                                                   challengeResponse: loginVerification)
            authorizeResponseData = try getAuthorizeResponseData(requestToken, authorizeRequestData: verificationData, username: username, password: password)
            if (authorizeResponseData.oauthPin?.isEmpty ?? true) {
                throw AuthenticationError.VerificationFailed
            }
            do {
                return try oauth.getAccessToken(requestToken, oauthVerifier: authorizeResponseData.oauthPin)
            } catch RestError.RequestError(_) {
                throw AuthenticationError.AccessTokenFailed
            }
        } catch RestError.NetworkError(let err) {
            throw AuthenticationError.NetworkError(err: err)
        }
    }

    func getAuthorizeRequestData(requestToken: OAuthToken) throws -> AuthorizeRequestData {
        var requestHeaders = [String: String]()
        if (browserUserAgent != nil) {
            requestHeaders["User-Agent"] = browserUserAgent!
        }
        let queries = ["oauth_token": requestToken.oauthToken]
        let data: AuthorizeRequestData
        do {
            try data = rest.makeTypedRequest(.GET, path: "/oauth/authorize", headers: requestHeaders, queries: queries, converter: AuthorizeRequestData.parseFromHttpResult)
        }
        data.referer = Endpoint.construct("https://api.twitter.com/", path: "/oauth/authorize", queries: queries)
        return data
    }
    
    func getAuthorizeResponseData(requestToken: OAuthToken,
                                  authorizeRequestData: AuthorizeRequestData,
                                  username: String, password: String) throws -> AuthorizeResponseData {
        var forms = [String: AnyObject]()
        forms["oauth_token"] = requestToken.oauthToken
        forms["authenticity_token"] = authorizeRequestData.authenticityToken
        forms["redirect_after_login"] = authorizeRequestData.redirectAfterLogin
        
        forms["session[username_or_email]"] = username
        forms["session[password]"] = password
        
        var requestHeaders = [String: String]()
        if (browserUserAgent != nil) {
            requestHeaders["User-Agent"] = browserUserAgent!
        }
        
        let data: AuthorizeResponseData
        do {
            try data = rest.makeTypedRequest(.POST, path: "/oauth/authorize", headers: requestHeaders, forms: forms, converter: AuthorizeResponseData.parseFromHttpResult)
        }
        data.referer = authorizeRequestData.referer
        return data
    }
    
    private func getVerificationData(authorizeResponseData: AuthorizeResponseData,
                             challengeResponse: String?) throws -> AuthorizeRequestData {
        var forms = [String: AnyObject]()
        let verification = authorizeResponseData.challenge!
        forms["authenticity_token"] = verification.authenticityToken
        forms["user_id"] = verification.userId
        forms["challenge_id"] = verification.challengeId
        forms["challenge_type"] = verification.challengeType
        forms["platform"] = verification.platform
        forms["redirect_after_login"] = verification.redirectAfterLogin
        
        if (challengeResponse != nil) {
            forms["challenge_response"] = challengeResponse!
        }
        
        var requestHeaders = [String: String]()
        if (browserUserAgent != nil) {
            requestHeaders["User-Agent"] = browserUserAgent!
        }
        
        let data: AuthorizeRequestData
        do {
            try data = rest.makeTypedRequest(.POST, path: "/account/login_verification", headers: requestHeaders, forms: forms, converter: AuthorizeRequestData.parseFromHttpResult)
        }
        if (data.authenticityToken?.isEmpty ?? true) {
            // TODO verification failed
        }
        return data
    }
}

enum AuthenticationError: ErrorType {
    case RequestTokenFailed
    case AccessTokenFailed
    case WrongUsernamePassword
    case VerificationFailed
    case NetworkError(err: NSError?)
}

internal class AuthorizeRequestData {
    var authenticityToken: String? = nil
    var redirectAfterLogin: String? = nil
    
    var referer: String? = nil
    
    static func parseFromHttpResult(result: HttpResult) -> AuthorizeRequestData {
        let data = AuthorizeRequestData()
        if let doc = Kanna.HTML(html: result.data!, encoding: NSUTF8StringEncoding) {
            
            let oauthForm = doc.at_css("form#oauth_form")
            if (oauthForm != nil) {
                data.authenticityToken = oauthForm!.at_css("input[name=\"authenticity_token\"]")?["value"]
                data.redirectAfterLogin = oauthForm!.at_css("input[name=\"redirect_after_login\"]")?["value"]
            }
        }
        return data
    }
}


internal class AuthorizeResponseData {
    
    var oauthPin: String? = nil
    var challenge: Verification? = nil
    
    var referer: String? = nil
    
    internal class Verification {
        
        var authenticityToken: String? = nil
        var challengeId: String? = nil
        var challengeType: String? = nil
        var platform: String? = nil
        var userId: String? = nil
        var redirectAfterLogin: String? = nil
    }
    
    static func parseFromHttpResult(result: HttpResult) throws -> AuthorizeResponseData {
        let data = AuthorizeResponseData()
        
        if let doc = Kanna.HTML(html: result.data!, encoding: NSUTF8StringEncoding) {
            
            // Find OAuth pin
            if let oauthPin = doc.at_css("div#oauth_pin") {
                let numericSet = NSCharacterSet.decimalDigitCharacterSet().invertedSet
                data.oauthPin = try oauthPin.css("*").filter({ (child) -> Bool in
                    if (child.text == nil) {
                        return false
                    }
                    return child.text!.rangeOfCharacterFromSet(numericSet) == nil
                }).first?.text
            } else if let challangeForm = doc.at_css("form#login-verification-form") ?? doc.at_css("form#login-challenge-form") {
                
                let challenge = Verification()
                
                challenge.authenticityToken = challangeForm.at_css("input[name=\"authenticity_token\"]")?["value"]
                challenge.challengeId = challangeForm.at_css("input[name=\"challenge_id\"]")?["value"]
                challenge.challengeType = challangeForm.at_css("input[name=\"challenge_type\"]")?["value"]
                challenge.platform = challangeForm.at_css("input[name=\"platform\"]")?["value"]
                challenge.userId = challangeForm.at_css("input[name=\"user_id\"]")?["value"]
                challenge.redirectAfterLogin = challangeForm.at_css("input[name=\"redirect_after_login\"]")?["value"]
             
                
                data.challenge = challenge
            }
            
        }
        return data
    }
}