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
