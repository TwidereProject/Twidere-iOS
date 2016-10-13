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
        return getProfileImageUrlForSize(userProfileImage, size: size)
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
        return Status(_id: -1, accountKey: self.accountKey, sortId: -1, positionKey: -1, isGap: false, createdAt: self.quotedCreatedAt!, id: quotedId, userKey: self.quotedUserKey!, userName: self.quotedUserName!, userScreenName: self.quotedUserScreenName!, userProfileImage: self.quotedUserProfileImage!, textPlain: self.quotedTextPlain!, textDisplay: self.quotedTextDisplay!, metadata: self.quotedMetadata!, quotedId: nil, quotedCreatedAt: nil, quotedUserKey: nil, quotedUserName: nil, quotedUserScreenName: nil, quotedUserProfileImage: nil, quotedTextPlain: nil, quotedTextDisplay: nil, quotedMetadata: nil, retweetedByUserKey: nil, retweetedByUserName: nil, retweetedByUserScreenName: nil, retweetedByUserProfileImage: nil, retweetId: nil, retweetCreatedAt: nil)
    }
    
    var user: User {
        return User(_id: -1, accountKey: self.accountKey, key: self.userKey, createdAt: nil, position: -1, isProtected: false, isVerified: false, name: self.userName, screenName: self.userScreenName, profileImageUrl: self.userProfileImage, profileBannerUrl: nil, profileBackgroundUrl: nil, descriptionPlain: nil, descriptionDisplay: nil, url: nil, urlExpanded: nil, location: nil, metadata: nil)
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
