//
//  User.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

}

extension User {
    
    @NSManaged var key: String?
    @NSManaged var name: String?
    @NSManaged var screenName: String?
    @NSManaged var type: String?
    @NSManaged var profileImageUrl: String?
    @NSManaged var profileBannerUrl: String?
    @NSManaged var profileBackgroundUrl: String?
    
}
