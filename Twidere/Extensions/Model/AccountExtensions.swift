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
        config.apiUrlFormat = credentials.apiUrlFormat
        config.authType = self.authType
        config.consumerKey = credentials.consumerKey!
        config.consumerSecret = credentials.consumerSecret!
        config.sameOAuthSigningUrl = credentials.sameOAuthSigningUrl
        config.noVersionSuffix = credentials.noVersionSuffix
        return config
    }
    
    func createAuthorization() -> Authorization {
        switch authType {
        case .oauth, .xAuth:
            let token = OAuthToken(credentials.accessToken, credentials.accessTokenSecret)
            return OAuthAuthorization(credentials.consumerKey, credentials.consumerSecret, oauthToken: token)
        case .basic:
            return BasicAuthorization(username: credentials.basicUsername, password: credentials.basicPassword)
        case .empty:
            return EmptyAuthorization()
        }
    }
    
    func createClientUserAgent() -> String? {
        switch authType {
        case .oauth, .xAuth:
            switch credentials.consumerKey.sha1() {
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
 
}
