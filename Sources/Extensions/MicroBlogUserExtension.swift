//
//  MicroBlogUserExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension MicroBlogUser {
    var key: UserKey? {
        return UserKey(id: id, host: self.host)
    }

    var host: String? {
        if (isFanfouUser) {
            return "fanfou.com"
        } else if let url = statusnetProfileUrl {
            return NSURLComponents(string: url)?.host
        } else {
            return "twitter.com"
        }
    }
    
    var isFanfouUser: Bool {
        return uniqueId != nil && profileImageUrlLarge != nil
    }
    
    func getProfileImage(ofSize: String) -> String! {
        if ("normal" != ofSize) {
            if let larger = profileImageUrlLarge {
                return larger
            }
        }
        let profileImage = profileImageUrlHttps ?? profileImageUrl
        //return Utils.getTwitterProfileImageOfSize(profileImage, size) ?: profileImage
        return profileImage
    }
    
    
    static func getUserHost(_ url: String!, def: String? = nil) -> String! {
        let def = def ?? "twitter.com"
        if (url == nil) {
            return def
        }
        guard let authority = NSURLComponents(string: url)?.host else {
            return nil
        }
        // TODO: replace invalid characters
        return authority
    }
}
