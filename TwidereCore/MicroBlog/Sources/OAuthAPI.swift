//
//  OAuthService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import PromiseKit
import RestClient

// sourcery: restProtocol
protocol OAuthAPI {
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/oauth/request_token
    // sourcery: restSerializer=OAuthTokenResponseSerializer
    func getRequestToken(/* sourcery: param=oauth_callback */_ oauthCallback: String) -> Promise<OAuthToken>
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/oauth/access_token
    // sourcery: restSerializer=OAuthTokenResponseSerializer
    // sourcery: restParams=x_auth_mode%3Dclient_auth
    func getAccessToken(/* sourcery: param=x_auth_username */username: String, /* sourcery: param=x_auth_password */password: String) -> Promise<OAuthToken>
    
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/oauth/access_token
    // sourcery: restSerializer=OAuthTokenResponseSerializer
    func getAccessToken(/* sourcery: param=oauth_verifier */_ verifier: String?) -> Promise<OAuthToken>
    
}
