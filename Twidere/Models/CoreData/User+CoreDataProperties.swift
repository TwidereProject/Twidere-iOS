//
//  User+CoreDataProperties.swift
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

extension User {

    @NSManaged var key: String?
    @NSManaged var name: String?
    @NSManaged var profileBackgroundUrl: String?
    @NSManaged var profileBannerUrl: String?
    @NSManaged var profileImageUrl: String?
    @NSManaged var screenName: String?
    @NSManaged var type: String?

}
