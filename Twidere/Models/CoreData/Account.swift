//
//  Account.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import CoreData

@objc(Account)
class Account: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    
    func createAPIConfig() -> CustomAPIConfig {
        let config = CustomAPIConfig()
        config.apiUrlFormat = apiUrlFormat!
        config.authType = CustomAPIConfig.AuthType(rawValue: authType!) ?? ServiceConstants.defaultAuthType
        config.consumerKey = consumerKey!
        config.consumerSecret = consumerSecret!
        config.sameOAuthSigningUrl = Bool(sameOAuthSigningUrl!)
        config.noVersionSuffix = Bool(noVersionSuffix!)
        return config
    }
    
    func createAuthorization() -> Authorization {
        switch CustomAPIConfig.AuthType(rawValue: authType!) ?? ServiceConstants.defaultAuthType {
        case .OAuth, .xAuth:
            let token = OAuthToken(oauthToken!, oauthTokenSecret!)
            return OAuthAuthorization(consumerKey!, consumerSecret!, oauthToken: token)
        case .Basic:
            return BasicAuthorization(username: basicUsername!, password: basicPassword!)
        case .TwipO:
            return EmptyAuthorization()
        }
    }
}
