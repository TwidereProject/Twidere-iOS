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
        let quoted = Status()
        quoted.id = quotedId
        quoted.accountKey = self.accountKey
        quoted.createdAt = self.quotedCreatedAt
        quoted.sortId = self.generateSortId(rawId: -1)
        quoted.accountKey = self.accountKey
        quoted.userKey = self.quotedUserKey
        quoted.userName = self.quotedUserName
        quoted.userScreenName = self.quotedUserScreenName
        quoted.userProfileImage = self.quotedUserProfileImage
        quoted.textPlain = self.quotedTextPlain
        quoted.textDisplay = self.quotedTextDisplay
        quoted.metadata = self.quotedMetadata
        return quoted
    }
    
    var user: User {
        let user = User()
        user.accountKey = self.accountKey
        user.key = self.userKey
        user.screenName = self.userScreenName
        user.name = self.userName
        user.profileImageUrl = self.userProfileImage
        return user
    }
    
    var statusUrl: String {
        if let externalUrl = self.metadata?.externalUrl {
            return externalUrl
        }
        if self.accountKey.host == "fanfou.com" {
            return "http://fanfou.com/statuses/\(self.id!)"
        }
        return "https://twitter.com/\(self.userScreenName!)/status/\(self.id!)"
    }
}
