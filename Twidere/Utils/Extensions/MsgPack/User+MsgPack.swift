import MessagePack_swift

import Foundation

extension User {

    convenience init(_ value: MessagePackValue) {
        value.dictionaryValue?.forEach { k, v in
            guard let ks = k.stringValue else {
                return
            }
            switch ks {
            case "_id":
                self._id = v.int64Value
            case "accountKey":
                self.accountKey = v.userKeyValue
            case "key":
                self.key = v.userKeyValue
            case "createdAt":
                self.createdAt = v.nSDateValue
            case "position":
                self.position = v.int64Value
            case "isProtected":
                self.isProtected = v.boolValue
            case "isVerified":
                self.isVerified = v.boolValue
            case "name":
                self.name = v.stringValue
            case "screenName":
                self.screenName = v.stringValue
            case "profileImageUrl":
                self.profileImageUrl = v.stringValue
            case "profileBannerUrl":
                self.profileBannerUrl = v.stringValue
            case "profileBackgroundUrl":
                self.profileBackgroundUrl = v.stringValue
            case "descriptionPlain":
                self.descriptionPlain = v.stringValue
            case "descriptionDisplay":
                self.descriptionDisplay = v.stringValue
            case "url":
                self.url = v.stringValue
            case "urlExpanded":
                self.urlExpanded = v.stringValue
            case "location":
                self.location = v.stringValue
            case "metadata":
                self.metadata = v.metadataValue
            default: break
            }
        }
    }

    func messagePackValue() -> MessagePackValue {
        var map: [MessagePackValue: MessagePackValue] = [:]
        if (self._id != nil) {
            map[.String("_id")] = MessagePackValue(self._id!)
        }
        if (self.accountKey != nil) {
            map[.String("accountKey")] = MessagePackValue(self.accountKey!)
        }
        if (self.key != nil) {
            map[.String("key")] = MessagePackValue(self.key!)
        }
        if (self.createdAt != nil) {
            map[.String("createdAt")] = MessagePackValue(self.createdAt!)
        }
        if (self.position != nil) {
            map[.String("position")] = MessagePackValue(self.position!)
        }
        if (self.isProtected != nil) {
            map[.String("isProtected")] = MessagePackValue(self.isProtected!)
        }
        if (self.isVerified != nil) {
            map[.String("isVerified")] = MessagePackValue(self.isVerified!)
        }
        if (self.name != nil) {
            map[.String("name")] = MessagePackValue(self.name!)
        }
        if (self.screenName != nil) {
            map[.String("screenName")] = MessagePackValue(self.screenName!)
        }
        if (self.profileImageUrl != nil) {
            map[.String("profileImageUrl")] = MessagePackValue(self.profileImageUrl!)
        }
        if (self.profileBannerUrl != nil) {
            map[.String("profileBannerUrl")] = MessagePackValue(self.profileBannerUrl!)
        }
        if (self.profileBackgroundUrl != nil) {
            map[.String("profileBackgroundUrl")] = MessagePackValue(self.profileBackgroundUrl!)
        }
        if (self.descriptionPlain != nil) {
            map[.String("descriptionPlain")] = MessagePackValue(self.descriptionPlain!)
        }
        if (self.descriptionDisplay != nil) {
            map[.String("descriptionDisplay")] = MessagePackValue(self.descriptionDisplay!)
        }
        if (self.url != nil) {
            map[.String("url")] = MessagePackValue(self.url!)
        }
        if (self.urlExpanded != nil) {
            map[.String("urlExpanded")] = MessagePackValue(self.urlExpanded!)
        }
        if (self.location != nil) {
            map[.String("location")] = MessagePackValue(self.location!)
        }
        if (self.metadata != nil) {
            map[.String("metadata")] = MessagePackValue(self.metadata!)
        }
        return map
    }

}

extension MessagePackValue {
    init(_ value: User) {
        self = value.messagePackValue()
    }

    var userValue: User? {
        switch self {
        case let .Map(map):
            return User(map)
        default:
            return nil
        }
    }
}


extension User.Metadata {

    convenience init(_ value: MessagePackValue) {
        value.dictionaryValue?.forEach { k, v in
            guard let ks = k.stringValue else {
                return
            }
            switch ks {
            case "following":
                self.following = v.boolValue
            case "followedBy":
                self.followedBy = v.boolValue
            case "blocking":
                self.blocking = v.boolValue
            case "blockedBy":
                self.blockedBy = v.boolValue
            case "muting":
                self.muting = v.boolValue
            case "followRequestSent":
                self.followRequestSent = v.boolValue
            case "statusesCount":
                self.statusesCount = v.int64Value
            case "followersCount":
                self.followersCount = v.int64Value
            case "friendsCount":
                self.friendsCount = v.int64Value
            case "favoritesCount":
                self.favoritesCount = v.int64Value
            case "mediaCount":
                self.mediaCount = v.int64Value
            case "listsCount":
                self.listsCount = v.int64Value
            case "listedCount":
                self.listedCount = v.int64Value
            case "groupsCount":
                self.groupsCount = v.int64Value
            default: break
            }
        }
    }

    func messagePackValue() -> MessagePackValue {
        var map: [MessagePackValue: MessagePackValue] = [:]
        if (self.following != nil) {
            map[.String("following")] = MessagePackValue(self.following!)
        }
        if (self.followedBy != nil) {
            map[.String("followedBy")] = MessagePackValue(self.followedBy!)
        }
        if (self.blocking != nil) {
            map[.String("blocking")] = MessagePackValue(self.blocking!)
        }
        if (self.blockedBy != nil) {
            map[.String("blockedBy")] = MessagePackValue(self.blockedBy!)
        }
        if (self.muting != nil) {
            map[.String("muting")] = MessagePackValue(self.muting!)
        }
        if (self.followRequestSent != nil) {
            map[.String("followRequestSent")] = MessagePackValue(self.followRequestSent!)
        }
        if (self.statusesCount != nil) {
            map[.String("statusesCount")] = MessagePackValue(self.statusesCount!)
        }
        if (self.followersCount != nil) {
            map[.String("followersCount")] = MessagePackValue(self.followersCount!)
        }
        if (self.friendsCount != nil) {
            map[.String("friendsCount")] = MessagePackValue(self.friendsCount!)
        }
        if (self.favoritesCount != nil) {
            map[.String("favoritesCount")] = MessagePackValue(self.favoritesCount!)
        }
        if (self.mediaCount != nil) {
            map[.String("mediaCount")] = MessagePackValue(self.mediaCount!)
        }
        if (self.listsCount != nil) {
            map[.String("listsCount")] = MessagePackValue(self.listsCount!)
        }
        if (self.listedCount != nil) {
            map[.String("listedCount")] = MessagePackValue(self.listedCount!)
        }
        if (self.groupsCount != nil) {
            map[.String("groupsCount")] = MessagePackValue(self.groupsCount!)
        }
        return map
    }
}

extension MessagePackValue {
    init(_ value: User.Metadata) {
        self = value.messagePackValue()
    }

    var userMetadataValue: User.Metadata? {
        switch self {
        case let .Map(map):
            return User.Metadata(map)
        default:
            return nil
        }
    }
}
