//
//  AccountConfig+CoreDataProperties.swift
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

extension AccountConfig {

    @NSManaged var characterLimit: NSNumber?
    @NSManaged var account: Account?

}
