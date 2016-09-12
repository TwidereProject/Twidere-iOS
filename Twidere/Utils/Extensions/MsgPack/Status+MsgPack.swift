import MessagePack_swift

import Foundation

extension Status {

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
            case "sortId":
                self.sortId = v.int64Value
            case "positionKey":
                self.positionKey = v.int64Value
            case "isGap":
                self.isGap = v.boolValue
            case "createdAt":
                self.createdAt = v.nSDateValue
            case "id":
                self.id = v.stringValue
            case "userKey":
                self.userKey = v.userKeyValue
            case "userName":
                self.userName = v.stringValue
            case "userScreenName":
                self.userScreenName = v.stringValue
            case "userProfileImage":
                self.userProfileImage = v.stringValue
            case "textPlain":
                self.textPlain = v.stringValue
            case "textDisplay":
                self.textDisplay = v.stringValue
            case "metadata":
                self.metadata = v.metadataValue
            case "quotedId":
                self.quotedId = v.stringValue
            case "quotedUserKey":
                self.quotedUserKey = v.userKeyValue
            case "quotedUserName":
                self.quotedUserName = v.stringValue
            case "quotedUserScreenName":
                self.quotedUserScreenName = v.stringValue
            case "quotedUserProfileImage":
                self.quotedUserProfileImage = v.stringValue
            case "quotedTextPlain":
                self.quotedTextPlain = v.stringValue
            case "quotedTextDisplay":
                self.quotedTextDisplay = v.stringValue
            case "quotedMetadata":
                self.quotedMetadata = v.metadataValue
            case "retweetedByUserKey":
                self.retweetedByUserKey = v.userKeyValue
            case "retweetedByUserName":
                self.retweetedByUserName = v.stringValue
            case "retweetedByUserScreenName":
                self.retweetedByUserScreenName = v.stringValue
            case "retweetedByUserProfileImage":
                self.retweetedByUserProfileImage = v.stringValue
            case "retweetId":
                self.retweetId = v.stringValue
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
        if (self.sortId != nil) {
            map[.String("sortId")] = MessagePackValue(self.sortId!)
        }
        if (self.positionKey != nil) {
            map[.String("positionKey")] = MessagePackValue(self.positionKey!)
        }
        if (self.isGap != nil) {
            map[.String("isGap")] = MessagePackValue(self.isGap!)
        }
        if (self.createdAt != nil) {
            map[.String("createdAt")] = MessagePackValue(self.createdAt!)
        }
        if (self.id != nil) {
            map[.String("id")] = MessagePackValue(self.id!)
        }
        if (self.userKey != nil) {
            map[.String("userKey")] = MessagePackValue(self.userKey!)
        }
        if (self.userName != nil) {
            map[.String("userName")] = MessagePackValue(self.userName!)
        }
        if (self.userScreenName != nil) {
            map[.String("userScreenName")] = MessagePackValue(self.userScreenName!)
        }
        if (self.userProfileImage != nil) {
            map[.String("userProfileImage")] = MessagePackValue(self.userProfileImage!)
        }
        if (self.textPlain != nil) {
            map[.String("textPlain")] = MessagePackValue(self.textPlain!)
        }
        if (self.textDisplay != nil) {
            map[.String("textDisplay")] = MessagePackValue(self.textDisplay!)
        }
        if (self.metadata != nil) {
            map[.String("metadata")] = MessagePackValue(self.metadata!)
        }
        if (self.quotedId != nil) {
            map[.String("quotedId")] = MessagePackValue(self.quotedId!)
        }
        if (self.quotedUserKey != nil) {
            map[.String("quotedUserKey")] = MessagePackValue(self.quotedUserKey!)
        }
        if (self.quotedUserName != nil) {
            map[.String("quotedUserName")] = MessagePackValue(self.quotedUserName!)
        }
        if (self.quotedUserScreenName != nil) {
            map[.String("quotedUserScreenName")] = MessagePackValue(self.quotedUserScreenName!)
        }
        if (self.quotedUserProfileImage != nil) {
            map[.String("quotedUserProfileImage")] = MessagePackValue(self.quotedUserProfileImage!)
        }
        if (self.quotedTextPlain != nil) {
            map[.String("quotedTextPlain")] = MessagePackValue(self.quotedTextPlain!)
        }
        if (self.quotedTextDisplay != nil) {
            map[.String("quotedTextDisplay")] = MessagePackValue(self.quotedTextDisplay!)
        }
        if (self.quotedMetadata != nil) {
            map[.String("quotedMetadata")] = MessagePackValue(self.quotedMetadata!)
        }
        if (self.retweetedByUserKey != nil) {
            map[.String("retweetedByUserKey")] = MessagePackValue(self.retweetedByUserKey!)
        }
        if (self.retweetedByUserName != nil) {
            map[.String("retweetedByUserName")] = MessagePackValue(self.retweetedByUserName!)
        }
        if (self.retweetedByUserScreenName != nil) {
            map[.String("retweetedByUserScreenName")] = MessagePackValue(self.retweetedByUserScreenName!)
        }
        if (self.retweetedByUserProfileImage != nil) {
            map[.String("retweetedByUserProfileImage")] = MessagePackValue(self.retweetedByUserProfileImage!)
        }
        if (self.retweetId != nil) {
            map[.String("retweetId")] = MessagePackValue(self.retweetId!)
        }
        return map
    }

}

extension MessagePackValue {
    init(_ value: Status) {
        self = value.messagePackValue()
    }

    var statusValue: Status? {
        switch self {
        case let .Map(map):
            return Status(map)
        default:
            return nil
        }
    }
}


extension Status.Metadata {

    convenience init(_ value: MessagePackValue) {
        value.dictionaryValue?.forEach { k, v in
            guard let ks = k.stringValue else {
                return
            }
            switch ks {
            case "links":
                self.links = v.linkSpanItem]?Value
            case "mentions":
                self.mentions = v.mentionSpanItem]?Value
            case "hashtags":
                self.hashtags = v.hashtagSpanItem]?Value
            case "media":
                self.media = v.mediaItem]?Value
            case "displayRange":
                self.displayRange = v.int]?Value
            default: break
            }
        }
    }

    func messagePackValue() -> MessagePackValue {
        var map: [MessagePackValue: MessagePackValue] = [:]
        if (self.links != nil) {
            map[.String("links")] = MessagePackValue(self.links!)
        }
        if (self.mentions != nil) {
            map[.String("mentions")] = MessagePackValue(self.mentions!)
        }
        if (self.hashtags != nil) {
            map[.String("hashtags")] = MessagePackValue(self.hashtags!)
        }
        if (self.media != nil) {
            map[.String("media")] = MessagePackValue(self.media!)
        }
        if (self.displayRange != nil) {
            map[.String("displayRange")] = MessagePackValue(self.displayRange!)
        }
        return map
    }
}

extension MessagePackValue {
    init(_ value: Status.Metadata) {
        self = value.messagePackValue()
    }

    var statusMetadataValue: Status.Metadata? {
        switch self {
        case let .Map(map):
            return Status.Metadata(map)
        default:
            return nil
        }
    }
}
