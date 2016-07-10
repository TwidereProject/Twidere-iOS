//
//  CustomAPIConfig.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class CustomAPIConfig {
    
    var apiUrlFormat: String = ""
    var authType: AuthType = .OAuth
    var sameOAuthUrl: Bool = true
    var noVersionSuffix: Bool = false
    var consumerKey: String = ""
    var consumerSecret: String = ""
    
    var valid: Bool {
        get {
            // Must have a valid API URL format
            if (apiUrlFormat.isEmpty) {
                return false
            }
            switch authType {
            case .OAuth, .xAuth:
                return !consumerKey.isEmpty && !consumerSecret.isEmpty
            default:
                return true
            }
        }
    }
    
    
    enum AuthType {
        case OAuth, xAuth, Basic, TwipO
    }
}
