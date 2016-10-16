//
//  FlatStatusExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

func < (lhs: Status, rhs: Status) -> Bool {
    return lhs.sortId < rhs.sortId
}

func > (lhs: Status, rhs: Status) -> Bool {
    return lhs.sortId > rhs.sortId
}

func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.accountKey == rhs.accountKey && lhs.sortId == rhs.sortId
}

extension Status {
    
    func userProfileImageForSize(_ size: ProfileImageSize) -> String? {
        guard let url = userProfileImage else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    func quotedUserProfileImageForSize(_ size: ProfileImageSize) -> String? {
        guard let url = quotedUserProfileImage else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    var quotedStatus: Status? {
        guard let quotedId = self.quotedId else {
            return nil
        }
        return Status(accountKey: self.accountKey, createdAt: self.quotedCreatedAt!, id: quotedId, userKey: self.quotedUserKey!, userName: self.quotedUserName!, userScreenName: self.quotedUserScreenName!, textPlain: self.quotedTextPlain!, textDisplay: self.quotedTextDisplay!, metadata: self.quotedMetadata)
    }
    
    var user: User {
        return User(accountKey: self.accountKey, key: self.userKey, name: self.userName, screenName: self.userScreenName, profileImageUrl: self.userProfileImage)
    }
    
    var statusUrl: String {
        if let externalUrl = self.metadata?.externalUrl {
            return externalUrl
        }
        if self.accountKey.host == "fanfou.com" {
            return "http://fanfou.com/statuses/\(self.id)"
        }
        return "https://twitter.com/\(self.userScreenName)/status/\(self.id)"
    }
}
