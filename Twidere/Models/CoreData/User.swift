//
//  User.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

class User: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    static func setFromJson(user: User, json: JSON) {
        user.key = UserKey(id: json["id_str"].string ?? json["id"].string!, host: getUserHost(json)).string
        user.name = json["name"].string
        user.screenName = json["screen_name"].string
        user.profileImageUrl = json["profile_image_url_https"].string ?? json["profile_image_url"].string
        user.profileBannerUrl = json["profile_banner_url"].string ?? json["cover_photo"].string
    }
    
    static func getUserHost(json: JSON) -> String {
        if (json["unique_id"].isExists() && json["profile_image_url_large"].isExists()) {
            return "fanfou.com"
        }
        return json["statusnet_profile_url"].string ?? "twitter.com"
    }
    
}
