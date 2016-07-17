//
//  Account.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
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

extension Account {
    
    @NSManaged var accountKey: String?
    @NSManaged var accountType: String?
    @NSManaged var authType: String?
    @NSManaged var apiUrlFormat: String?
    @NSManaged var consumerKey: String?
    @NSManaged var consumerSecret: String?
    @NSManaged var oauthToken: String?
    @NSManaged var oauthTokenSecret: String?
    @NSManaged var sameOAuthSigningUrl: NSNumber?
    @NSManaged var noVersionSuffix: NSNumber?
    @NSManaged var basicUsername: String?
    @NSManaged var basicPassword: String?
    @NSManaged var user: AccountUser?
    
}
