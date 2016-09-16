//
//  TwitterOAuthPasswordAuthenticator.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Kanna
import PromiseKit
import Alamofire

class TwitterOAuthPasswordAuthenticator {
    
    let oauth: OAuthService
    let rest: RestClient
    let loginVerificationCallback: ((_ challangeType: String) -> String?)
    let browserUserAgent: String?
    
    init(endpoint: Endpoint, consumerKey:String, consumerSecret: String, loginVerificationCallback: @escaping ((_ challangeType: String) -> String?), browserUserAgent: String? = nil) {
        self.oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(consumerKey, consumerSecret))
        self.rest = RestClient(endpoint: endpoint)
        self.loginVerificationCallback = loginVerificationCallback
        self.browserUserAgent = browserUserAgent
    }
    
    func getOAuthAccessToken(_ username: String, password: String) -> Promise<OAuthToken> {
        return firstly { () -> Promise<OAuthToken> in
            return self.oauth.getRequestToken(oauthCallbackOob)
            }.then { requestToken -> Promise<AuthorizeRequestData> in
                return self.getAuthorizeRequestData(requestToken)
            }.then { authorizeRequestData -> Promise<AuthorizeResponseData> in
                return self.getAuthorizeResponseData(authorizeRequestData, username: username, password: password)
            }.recover { error throws -> Promise<AuthorizeResponseData> in
                // Got challange
                guard let authError = error as? AuthenticationError else {
                    throw error
                }
                switch authError {
                case .challangeRequired(let authorizeResponseData):
                    let challengeType = authorizeResponseData.challenge!.challengeType
                    if (challengeType == nil) {
                        throw AuthenticationError.verificationFailed
                    }
                    let loginVerification = self.loginVerificationCallback(challengeType!)
                    return self.getVerificationData(authorizeResponseData, challengeResponse: loginVerification).then { verificationData -> Promise<AuthorizeResponseData> in
                        return self.getAuthorizeResponseData(verificationData, username: username, password: password)
                    }
                default: break
                }
                throw error
            }.then { authorizeResponseData -> Promise<OAuthToken> in
                // Got oauth pin, fetch access token
                return self.oauth.getAccessToken(authorizeResponseData.requestToken, oauthVerifier: authorizeResponseData.oauthPin)
        }
    }
    
    func getAuthorizeRequestData(_ requestToken: OAuthToken) -> Promise<AuthorizeRequestData> {
        var requestHeaders = [String: String]()
        if (browserUserAgent != nil) {
            requestHeaders["User-Agent"] = browserUserAgent!
        }
        let queries = ["oauth_token": requestToken.oauthToken]
        
        return rest.makeTypedRequest(.get, path: "/oauth/authorize", headers: requestHeaders, queries: queries, serializer: DataResponseSerializer { (req, resp, data, error) -> Alamofire.Result<AuthorizeRequestData> in
            let result = AuthorizeRequestData.parseFromHttpResult(data!)
            result.requestToken = requestToken
            result.referer = Endpoint.construct("https://api.twitter.com/", path: "/oauth/authorize", queries: queries)
            return .success(result)
            })
    }
    
    func getAuthorizeResponseData(_ authorizeRequestData: AuthorizeRequestData,
                                  username: String, password: String) -> Promise<AuthorizeResponseData> {
        var forms = [String: Any]()
        forms["oauth_token"] = authorizeRequestData.requestToken.oauthToken
        forms["authenticity_token"] = authorizeRequestData.authenticityToken
        forms["redirect_after_login"] = authorizeRequestData.redirectAfterLogin
        
        forms["session[username_or_email]"] = username
        forms["session[password]"] = password
        
        var requestHeaders = [String: String]()
        if (browserUserAgent != nil) {
            requestHeaders["User-Agent"] = browserUserAgent!
        }
        
        return rest.makeTypedRequest(.post, path: "/oauth/authorize", headers: requestHeaders, params: forms, serializer: DataResponseSerializer { (req, resp, data, error) -> Alamofire.Result<AuthorizeResponseData> in
            let result = AuthorizeResponseData.parseFromHttpResult(data!)
            result.requestToken = authorizeRequestData.requestToken
            result.referer = authorizeRequestData.referer
            if (result.oauthPin != nil) {
                return .success(result)
            } else if (result.challenge != nil) {
                return .failure(AuthenticationError.challangeRequired(data: result))
            }
            return .failure(AuthenticationError.wrongUsernamePassword)
            })
        
    }
    
    fileprivate func getVerificationData(_ authorizeResponseData: AuthorizeResponseData,
                                     challengeResponse: String?) -> Promise<AuthorizeRequestData> {
        var forms = [String: Any]()
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
        
        return rest.makeTypedRequest(.post, path: "/account/login_verification", headers: requestHeaders, params: forms, serializer: DataResponseSerializer { (req, resp, data, error) -> Alamofire.Result<AuthorizeRequestData> in
            let result = AuthorizeRequestData.parseFromHttpResult(data!)
            
            if (result.authenticityToken?.isEmpty ?? true) {
                // TODO verification failed
                return .failure(AuthenticationError.verificationFailed)
            }
            return .success(result)
            })
        
    }
}

enum AuthenticationError: Error {
    case requestTokenFailed
    case accessTokenFailed
    case wrongUsernamePassword
    case verificationFailed
    case challangeRequired(data: AuthorizeResponseData)
    case networkError(err: NSError?)
}

internal class AuthorizeRequestData {
    var requestToken: OAuthToken!
    
    var authenticityToken: String? = nil
    var redirectAfterLogin: String? = nil
    
    var referer: String? = nil
    
    static func parseFromHttpResult(_ data: Data) -> AuthorizeRequestData {
        let result = AuthorizeRequestData()
        if let doc = Kanna.HTML(html: data, encoding: String.Encoding.utf8) {
            
            let oauthForm = doc.at_css("form#oauth_form")
            if (oauthForm != nil) {
                result.authenticityToken = oauthForm!.at_css("input[name=\"authenticity_token\"]")?["value"]
                result.redirectAfterLogin = oauthForm!.at_css("input[name=\"redirect_after_login\"]")?["value"]
            }
        }
        return result
    }
}


internal class AuthorizeResponseData {
    var requestToken: OAuthToken!
    
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
    
    static func parseFromHttpResult(_ data: Data) -> AuthorizeResponseData {
        let result = AuthorizeResponseData()
        
        if let doc = Kanna.HTML(html: data, encoding: String.Encoding.utf8) {
            
            // Find OAuth pin
            if let oauthPin = doc.at_css("div#oauth_pin") {
                let numericSet = CharacterSet.decimalDigits.inverted
                result.oauthPin = oauthPin.css("*").filter({ (child) -> Bool in
                    if (child.text == nil) {
                        return false
                    }
                    return child.text!.rangeOfCharacter(from: numericSet) == nil
                }).first?.text
            } else if let challangeForm = doc.at_css("form#login-verification-form") ?? doc.at_css("form#login-challenge-form") {
                
                let challenge = Verification()
                
                challenge.authenticityToken = challangeForm.at_css("input[name=\"authenticity_token\"]")?["value"]
                challenge.challengeId = challangeForm.at_css("input[name=\"challenge_id\"]")?["value"]
                challenge.challengeType = challangeForm.at_css("input[name=\"challenge_type\"]")?["value"]
                challenge.platform = challangeForm.at_css("input[name=\"platform\"]")?["value"]
                challenge.userId = challangeForm.at_css("input[name=\"user_id\"]")?["value"]
                challenge.redirectAfterLogin = challangeForm.at_css("input[name=\"redirect_after_login\"]")?["value"]
                
                
                result.challenge = challenge
            }
            
        }
        return result
    }
}
