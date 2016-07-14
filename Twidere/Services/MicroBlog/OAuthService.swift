//
//  OAuthService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class OAuthService: RestClient {
    
    func getRequestToken(oauthCallback: String) throws -> OAuthToken {
        let forms: [String: AnyObject] = ["oauth_callback": oauthCallback]
        do {
            return try makeTypedRequest(.POST, path: "/oauth/request_token", forms: forms, checker: MicroBlogService.checkRequest, converter: ModelConverter.oauthToken)
        }
    }
    
    func getAccessToken(xauthUsername:String, xauthPassword: String) throws -> OAuthToken {
        let forms: [String: AnyObject] = [
            "x_auth_mode": "client_auth",
            "x_auth_username": xauthUsername,
            "x_auth_password": xauthPassword
        ]
        do {
            return try makeTypedRequest(.POST, path: "/oauth/access_token", forms: forms, checker: MicroBlogService.checkRequest, converter: ModelConverter.oauthToken)
        }
    }
    
    
    func getAccessToken(requestToken: OAuthToken, oauthVerifier: String? = nil) throws -> OAuthToken {
        let forms: [String: AnyObject]
        if (oauthVerifier != nil) {
            forms = ["oauth_verifier": oauthVerifier!]
        } else {
            forms = [:]
        }
        var finalAuth = auth
        if (auth is OAuthAuthorization) {
            let oauth = auth as! OAuthAuthorization
            finalAuth = OAuthAuthorization(oauth.consumerKey, oauth.consumerSecret, oauthToken: requestToken)
        }
        do {
            return try makeTypedRequest(.POST, path: "/oauth/access_token", forms: forms, authOverride: finalAuth, checker: MicroBlogService.checkRequest, converter: ModelConverter.oauthToken)
        }
    }
    
}