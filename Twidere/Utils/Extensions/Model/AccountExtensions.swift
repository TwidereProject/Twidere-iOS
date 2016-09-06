//
//  AccountExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Account {
    func newMicroblogInstance(domain: String? = "api") -> MicroBlogService {
        let apiConfig = createAPIConfig()
        let endpoint = apiConfig.createEndpoint(domain)
        let auth = createAuthorization()
        return MicroBlogService(endpoint: endpoint, auth: auth)
    }
    
    var typeInferred: Type {
        get {
            switch accountType {
            case "fanfou"?:
                return .Fanfou
            default:
                return .Twitter
            }
        }
    }
    
    enum Type {
        case Twitter, Fanfou, StatusNet
    }
}