//
//  AccountExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import DeviceKit

extension Account {
    func createAPIConfig() -> CustomAPIConfig {
        let config = CustomAPIConfig()
        config.apiUrlFormat = apiUrlFormat
        config.authType = CustomAPIConfig.AuthType(rawValue: authType) ?? defaultAuthType
        config.consumerKey = consumerKey!
        config.consumerSecret = consumerSecret!
        config.sameOAuthSigningUrl = sameOAuthSigningUrl
        config.noVersionSuffix = noVersionSuffix
        return config
    }
    
    func createAuthorization() -> Authorization {
        switch CustomAPIConfig.AuthType(rawValue: authType) ?? defaultAuthType {
        case .OAuth, .xAuth:
            let token = OAuthToken(oauthToken!, oauthTokenSecret!)
            return OAuthAuthorization(consumerKey!, consumerSecret!, oauthToken: token)
        case .Basic:
            return BasicAuthorization(username: basicUsername!, password: basicPassword!)
        case .TwipO:
            return EmptyAuthorization()
        }
    }
    
    func createClientUserAgent() -> String? {
        switch CustomAPIConfig.AuthType(rawValue: authType) ?? defaultAuthType {
        case .OAuth, .xAuth:
            switch consumerKey!.sha1() {
            case "ec7250f480e5dedff7688c78188886c282a3d968":
                // Twitter for iPhone
                let device = Device()
                return "Twitter-iPhone/7.0.0 iOS/\(device.systemVersion) (Apple;\(Device.identifier);;;;;1)"
            default:
                break
            }
        default:
            break
        }
        return nil
    }
    
    func newMicroBlogService(_ domain: String? = "api") -> MicroBlogService {
        let apiConfig = createAPIConfig()
        let endpoint = apiConfig.createEndpoint(domain)
        let auth = createAuthorization()
        let userAgent = createClientUserAgent()
        let microBlog = MicroBlogService(endpoint: endpoint, auth: auth, userAgent: userAgent)
        microBlog.accountKey = self.key
        return microBlog
    }
    
    var typeInferred: AccountType {
        get {
            switch type {
            case "fanfou":
                return .fanfou
            default:
                return .twitter
            }
        }
    }
 
}
