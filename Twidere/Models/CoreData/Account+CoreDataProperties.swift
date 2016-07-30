//
//  Account+CoreDataProperties.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var accountKey: String?
    @NSManaged var accountType: String?
    @NSManaged var apiUrlFormat: String?
    @NSManaged var authType: String?
    @NSManaged var basicPassword: String?
    @NSManaged var basicUsername: String?
    @NSManaged var consumerKey: String?
    @NSManaged var consumerSecret: String?
    @NSManaged var noVersionSuffix: NSNumber?
    @NSManaged var oauthToken: String?
    @NSManaged var oauthTokenSecret: String?
    @NSManaged var sameOAuthSigningUrl: NSNumber?
    @NSManaged var user: AccountUser?
    @NSManaged var config: NSManagedObject?

}
