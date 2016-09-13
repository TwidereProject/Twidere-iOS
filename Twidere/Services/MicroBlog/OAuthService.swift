//
//  OAuthService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit

class OAuthService: RestClient {
    
    func getRequestToken(oauthCallback: String) -> Promise<OAuthToken> {
        let forms: [String: AnyObject] = ["oauth_callback": oauthCallback]
        return makeTypedRequest(.POST, path: "/oauth/request_token", params: forms, validation: MicroBlogService.checkRequest, serializer: ModelConverter.oauthToken)
    }
    
    func getAccessToken(xauthUsername:String, xauthPassword: String) -> Promise<OAuthToken> {
        let forms: [String: AnyObject] = [
            "x_auth_mode": "client_auth",
            "x_auth_username": xauthUsername,
            "x_auth_password": xauthPassword
        ]
        return makeTypedRequest(.POST, path: "/oauth/access_token", params: forms, validation: MicroBlogService.checkRequest, serializer: ModelConverter.oauthToken)
        
    }
    
    
    func getAccessToken(requestToken: OAuthToken, oauthVerifier: String? = nil) -> Promise<OAuthToken> {
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
        return makeTypedRequest(.POST, path: "/oauth/access_token", params: forms, authOverride: finalAuth, validation: MicroBlogService.checkRequest, serializer: ModelConverter.oauthToken)
        
    }
    
}