//
//  User.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    static func setFromJson(user: User, json: JSON) {
        user.key = json["id_str"].string ?? json["id"].string
        user.name = json["name"].string
        user.screenName = json["scren_name"].string
        user.profileImageUrl = json["profile_image_url_https"].string ?? json["profile_image_url"].string
    }
    
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
