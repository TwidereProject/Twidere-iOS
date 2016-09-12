//
//  AccountExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Account {
    func createAPIConfig() -> CustomAPIConfig {
        let config = CustomAPIConfig()
        config.apiUrlFormat = apiUrlFormat!
        config.authType = CustomAPIConfig.AuthType(rawValue: authType!) ?? defaultAuthType
        config.consumerKey = consumerKey!
        config.consumerSecret = consumerSecret!
        config.sameOAuthSigningUrl = Bool(sameOAuthSigningUrl!)
        config.noVersionSuffix = Bool(noVersionSuffix!)
        return config
    }
    
    func createAuthorization() -> Authorization {
        switch CustomAPIConfig.AuthType(rawValue: authType!) ?? defaultAuthType {
        case .OAuth, .xAuth:
            let token = OAuthToken(oauthToken!, oauthTokenSecret!)
            return OAuthAuthorization(consumerKey!, consumerSecret!, oauthToken: token)
        case .Basic:
            return BasicAuthorization(username: basicUsername!, password: basicPassword!)
        case .TwipO:
            return EmptyAuthorization()
        }
    }
    
    func newMicroblogInstance(domain: String? = "api") -> MicroBlogService {
        let apiConfig = createAPIConfig()
        let endpoint = apiConfig.createEndpoint(domain)
        let auth = createAuthorization()
        return MicroBlogService(endpoint: endpoint, auth: auth)
    }
    
    var typeInferred: AccountType {
        get {
            switch type {
            case "fanfou"?:
                return .Fanfou
            default:
                return .Twitter
            }
        }
    }
    
    enum AccountType {
        case Twitter, Fanfou, StatusNet
    }
}