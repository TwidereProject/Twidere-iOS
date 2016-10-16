//
//  User+MicroBlog.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON

extension User {
    
    convenience init?(from account: JSON) {
        self.init(json: account, accountKey: User.getUserKey(account))
    }
    
    convenience init?(json: JSON, accountKey: UserKey?) {
        let key = User.getUserKey(json, accountHost: accountKey?.host)
        let createdAt = parseTwitterDate(json["created_at"].stringValue)
        let isProtected = json["protected"].boolValue
        let isVerified = json["verified"].boolValue
        let name = json["name"].stringValue
        let screenName = json["screen_name"].stringValue
        let profileImageUrl = json["profile_image_url_https"].string ?? json["profile_image_url"].string
        let profileBannerUrl = json["profile_banner_url"].string ?? json["cover_photo"].string
        let profileBackgroundUrl = json["profile_background_image_url_https"].string ?? json["profile_background_image_url"].string
        let descriptionPlain = json["description"].string
        let descriptionDisplay = descriptionPlain
        let url = json["url"].string
        let urlExpanded = json["entities"]["url"]["urls"][0]["expanded_url"].string
        let location = json["location"].string
        let metadata = User.Metadata(json: json)
        self.init(accountKey: accountKey, key: key, createdAt: createdAt, isProtected: isProtected, isVerified: isVerified, name: name, screenName: screenName, profileImageUrl: profileImageUrl, profileBannerUrl: profileBannerUrl, profileBackgroundUrl: profileBackgroundUrl, descriptionPlain: descriptionPlain, descriptionDisplay: descriptionDisplay, url: url, urlExpanded: urlExpanded, location: location, metadata: metadata)
    }
    
    static func getUserKey(_ user: JSON, accountHost: String? = nil) -> UserKey {
        let id = user["id_str"].string ?? user["id"].stringValue
        return UserKey(id: id, host: User.getUserHost(user, accountHost: accountHost))
    }
    
    static func getUserHost(_ json: JSON, accountHost: String?) -> String? {
        if (json["unique_id"].exists() && json["profile_image_url_large"].exists()) {
            return "fanfou.com"
        }
        guard let profileUrl = json["statusnet_profile_url"].string else {
            return "twitter.com"
        }
        return NSURLComponents(string: profileUrl)!.host ?? accountHost
    }
    
    static func arrayFromJson(_ json: JSON, accountKey: UserKey?) -> [User] {
        if let array = json.array {
            return array.map { User(json: $0, accountKey: accountKey)! }
        } else {
            return json["users"].map { User(json: $1, accountKey: accountKey)! }
        }
    }
}

extension User.Metadata {
    
    convenience init(json: JSON) {
        let following = json["following"].boolValue
        let followedBy = json["followed_by"].bool ?? json["follows_you"].boolValue
        let blocking = json["blocking"].bool ?? json["statusnet_blocking"].boolValue
        let blockedBy = json["blocked_by"].bool ?? json["blocks_you"].boolValue
        let muting = json["muting"].boolValue
        let followRequestSent = json["follow_request_sent"].boolValue
        
        let linkColor = json["profile_link_color"].string ?? json["linkcolor"].string
        let backgroundColor = json["profile_background_color"].string ?? json["backgroundcolor"].string
        
        let statusesCount = json["statuses_count"].int64 ?? -1
        let favoritesCount = json["favourites_count"].int64 ?? -1
        let followersCount = json["followers_count"].int64 ?? -1
        let friendsCount = json["friends_count"].int64 ?? -1
        let mediaCount = json["media_count"].int64 ?? json["photo_count"].int64 ?? -1
        let listsCount = json["lists_count"].int64 ?? -1
        let listedCount = json["listed_count"].int64 ?? -1
        let groupsCount = json["groups_count"].int64 ?? -1
        
        self.init(following: following, followedBy: followedBy, blocking: blocking, blockedBy: blockedBy, muting: muting, followRequestSent: followRequestSent, descriptionLinks: nil, descriptionMentions: nil, descriptionHashtags: nil, linkColor: linkColor, backgroundColor: backgroundColor, statusesCount: statusesCount, followersCount: followersCount, friendsCount: friendsCount, favoritesCount: favoritesCount, mediaCount: mediaCount, listsCount: listsCount, listedCount: listedCount, groupsCount: groupsCount)
    }
    
}
