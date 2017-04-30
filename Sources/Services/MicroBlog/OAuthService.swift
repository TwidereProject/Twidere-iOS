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
    
    func getRequestToken(_ oauthCallback: String) -> Promise<OAuthToken> {
        let forms: [String: Any] = ["oauth_callback": oauthCallback]
        return makeTypedRequest(.post, path: "/oauth/request_token", params: forms, serializer: ModelConverter.oauthToken)
    }
    
    func getAccessToken(_ xauthUsername:String, xauthPassword: String) -> Promise<OAuthToken> {
        let forms: [String: Any] = [
            "x_auth_mode": "client_auth",
            "x_auth_username": xauthUsername,
            "x_auth_password": xauthPassword
        ]
        return makeTypedRequest(.post, path: "/oauth/access_token", params: forms, serializer: ModelConverter.oauthToken)
        
    }
    
    
    func getAccessToken(_ requestToken: OAuthToken, oauthVerifier: String? = nil) -> Promise<OAuthToken> {
        let forms: [String: Any]
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
        return makeTypedRequest(.post, path: "/oauth/access_token", params: forms, authOverride: finalAuth, serializer: ModelConverter.oauthToken)
        
    }
    
}
