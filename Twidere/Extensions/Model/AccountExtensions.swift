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
    
    func newMicroBlogService(_ domain: String? = "api") -> MicroBlogService {
        let apiConfig = createAPIConfig()
        let endpoint = apiConfig.createEndpoint(domain)
        let auth = createAuthorization()
        let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
        microBlog.accountKey = self.key
        return microBlog
    }
    
    var typeInferred: AccountType {
        get {
            switch type {
            case "fanfou"?:
                return .fanfou
            default:
                return .twitter
            }
        }
    }
    
    enum AccountType {
        case twitter, fanfou, statusNet
    }
}
