//
//  UserExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Regex
import SwiftyJSON


extension User {
    
    func profileImageUrlForSize(size: ProfileImageSize) -> String? {
        guard let url = profileImageUrl else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    func profileBannerUrlForSize(size: Int) -> String? {
        guard let url = profileBannerUrl else {
            return nil
        }
        return getProfileBannerUrlForSize(url, size: size)
    }
    
    // Insert code here to add functionality to your managed object subclass
    static func setFromJson(user: User, json: JSON) {
        user.key = UserKey(id: json["id_str"].string ?? json["id"].string!, host: getUserHost(json))
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