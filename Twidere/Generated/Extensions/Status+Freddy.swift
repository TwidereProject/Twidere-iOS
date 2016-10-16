// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Status: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status {
        let accountKey: UserKey? = try? value.decode(at: "account_key")
        let sortId: Int64 = try value.decode(at: "sort_id")
        let positionKey: Int64 = try value.decode(at: "position_key")
        let isGap: Bool = try value.decode(at: "is_gap")
        let createdAt: Date = try value.decode(at: "created_at")
        let id: String = try value.decode(at: "status_id")
        let userKey: UserKey = try value.decode(at: "user_key")
        let userName: String = try value.decode(at: "user_name")
        let userScreenName: String = try value.decode(at: "user_screen_name")
        let userProfileImage: String? = try? value.decode(at: "user_profile_image")
        let textPlain: String = try value.decode(at: "text_plain")
        let textDisplay: String = try value.decode(at: "text_display")
        let metadata: Metadata? = try? value.decode(at: "metadata")
        let quotedId: String? = try? value.decode(at: "quoted_status_id")
        let quotedCreatedAt: Date? = try? value.decode(at: "quoted_created_at")
        let quotedUserKey: UserKey? = try? value.decode(at: "quoted_user_key")
        let quotedUserName: String? = try? value.decode(at: "quoted_user_name")
        let quotedUserScreenName: String? = try? value.decode(at: "quoted_user_screen_name")
        let quotedUserProfileImage: String? = try? value.decode(at: "quoted_user_profile_image")
        let quotedTextPlain: String? = try? value.decode(at: "quoted_text_plain")
        let quotedTextDisplay: String? = try? value.decode(at: "quoted_text_display")
        let quotedMetadata: Metadata? = try? value.decode(at: "quoted_metadata")
        let retweetedByUserKey: UserKey? = try? value.decode(at: "retweeted_by_user_key")
        let retweetedByUserName: String? = try? value.decode(at: "retweeted_by_user_name")
        let retweetedByUserScreenName: String? = try? value.decode(at: "retweeted_by_user_screen_name")
        let retweetedByUserProfileImage: String? = try? value.decode(at: "retweeted_by_user_profile_image")
        let retweetId: String? = try? value.decode(at: "retweet_id")
        let retweetCreatedAt: Date? = try? value.decode(at: "retweet_created_at")
        return Status(accountKey: accountKey, sortId: sortId, positionKey: positionKey, isGap: isGap, createdAt: createdAt, id: id, userKey: userKey, userName: userName, userScreenName: userScreenName, userProfileImage: userProfileImage, textPlain: textPlain, textDisplay: textDisplay, metadata: metadata, quotedId: quotedId, quotedCreatedAt: quotedCreatedAt, quotedUserKey: quotedUserKey, quotedUserName: quotedUserName, quotedUserScreenName: quotedUserScreenName, quotedUserProfileImage: quotedUserProfileImage, quotedTextPlain: quotedTextPlain, quotedTextDisplay: quotedTextDisplay, quotedMetadata: quotedMetadata, retweetedByUserKey: retweetedByUserKey, retweetedByUserName: retweetedByUserName, retweetedByUserScreenName: retweetedByUserScreenName, retweetedByUserProfileImage: retweetedByUserProfileImage, retweetId: retweetId, retweetCreatedAt: retweetCreatedAt)
    }

}

extension Status: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        if (accountKey != nil) {
            dict["account_key"] = self.accountKey!.toJSON()
        }
        dict["sort_id"] = self.sortId.toJSON()
        dict["position_key"] = self.positionKey.toJSON()
        dict["is_gap"] = self.isGap.toJSON()
        dict["created_at"] = self.createdAt.toJSON()
        dict["status_id"] = self.id.toJSON()
        dict["user_key"] = self.userKey.toJSON()
        dict["user_name"] = self.userName.toJSON()
        dict["user_screen_name"] = self.userScreenName.toJSON()
        if (userProfileImage != nil) {
            dict["user_profile_image"] = self.userProfileImage!.toJSON()
        }
        dict["text_plain"] = self.textPlain.toJSON()
        dict["text_display"] = self.textDisplay.toJSON()
        if (metadata != nil) {
            dict["metadata"] = self.metadata!.toJSON()
        }
        if (quotedId != nil) {
            dict["quoted_status_id"] = self.quotedId!.toJSON()
        }
        if (quotedCreatedAt != nil) {
            dict["quoted_created_at"] = self.quotedCreatedAt!.toJSON()
        }
        if (quotedUserKey != nil) {
            dict["quoted_user_key"] = self.quotedUserKey!.toJSON()
        }
        if (quotedUserName != nil) {
            dict["quoted_user_name"] = self.quotedUserName!.toJSON()
        }
        if (quotedUserScreenName != nil) {
            dict["quoted_user_screen_name"] = self.quotedUserScreenName!.toJSON()
        }
        if (quotedUserProfileImage != nil) {
            dict["quoted_user_profile_image"] = self.quotedUserProfileImage!.toJSON()
        }
        if (quotedTextPlain != nil) {
            dict["quoted_text_plain"] = self.quotedTextPlain!.toJSON()
        }
        if (quotedTextDisplay != nil) {
            dict["quoted_text_display"] = self.quotedTextDisplay!.toJSON()
        }
        if (quotedMetadata != nil) {
            dict["quoted_metadata"] = self.quotedMetadata!.toJSON()
        }
        if (retweetedByUserKey != nil) {
            dict["retweeted_by_user_key"] = self.retweetedByUserKey!.toJSON()
        }
        if (retweetedByUserName != nil) {
            dict["retweeted_by_user_name"] = self.retweetedByUserName!.toJSON()
        }
        if (retweetedByUserScreenName != nil) {
            dict["retweeted_by_user_screen_name"] = self.retweetedByUserScreenName!.toJSON()
        }
        if (retweetedByUserProfileImage != nil) {
            dict["retweeted_by_user_profile_image"] = self.retweetedByUserProfileImage!.toJSON()
        }
        if (retweetId != nil) {
            dict["retweet_id"] = self.retweetId!.toJSON()
        }
        if (retweetCreatedAt != nil) {
            dict["retweet_created_at"] = self.retweetCreatedAt!.toJSON()
        }
        return .dictionary(dict)
    }
}
extension Status.Metadata: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status.Metadata {
        let links: [LinkSpanItem]? = try? value.decodedArray(at: "links")
        let mentions: [MentionSpanItem]? = try? value.decodedArray(at: "mentions")
        let hashtags: [HashtagSpanItem]? = try? value.decodedArray(at: "hashtags")
        let media: [MediaItem]? = try? value.decodedArray(at: "media")
        let displayRange: [Int]? = try? value.decodedArray(at: "display_range")
        let inReplyTo: InReplyTo? = try? value.decode(at: "in_reply_to")
        let externalUrl: String? = try? value.decode(at: "extenral_url")
        let replyCount: Int64 = try value.decode(at: "reply_count")
        let retweetCount: Int64 = try value.decode(at: "retweet_count")
        let favoriteCount: Int64 = try value.decode(at: "favorite_count")
        return Status.Metadata(links: links, mentions: mentions, hashtags: hashtags, media: media, displayRange: displayRange, inReplyTo: inReplyTo, externalUrl: externalUrl, replyCount: replyCount, retweetCount: retweetCount, favoriteCount: favoriteCount)
    }

}

extension Status.Metadata: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        if (links != nil) {
            dict["links"] = self.links!.toJSON()
        }
        if (mentions != nil) {
            dict["mentions"] = self.mentions!.toJSON()
        }
        if (hashtags != nil) {
            dict["hashtags"] = self.hashtags!.toJSON()
        }
        if (media != nil) {
            dict["media"] = self.media!.toJSON()
        }
        if (displayRange != nil) {
            dict["display_range"] = self.displayRange!.toJSON()
        }
        if (inReplyTo != nil) {
            dict["in_reply_to"] = self.inReplyTo!.toJSON()
        }
        if (externalUrl != nil) {
            dict["extenral_url"] = self.externalUrl!.toJSON()
        }
        dict["reply_count"] = self.replyCount.toJSON()
        dict["retweet_count"] = self.retweetCount.toJSON()
        dict["favorite_count"] = self.favoriteCount.toJSON()
        return .dictionary(dict)
    }
}
extension Status.Metadata.InReplyTo: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status.Metadata.InReplyTo {
        let statusId: String = try value.decode(at: "status_id")
        let userKey: UserKey = try value.decode(at: "user_key")
        let userName: String? = try? value.decode(at: "user_name")
        let userScreenName: String = try value.decode(at: "user_screen_name")
        return Status.Metadata.InReplyTo(statusId: statusId, userKey: userKey, userName: userName, userScreenName: userScreenName)
    }

}

extension Status.Metadata.InReplyTo: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["status_id"] = self.statusId.toJSON()
        dict["user_key"] = self.userKey.toJSON()
        if (userName != nil) {
            dict["user_name"] = self.userName!.toJSON()
        }
        dict["user_screen_name"] = self.userScreenName.toJSON()
        return .dictionary(dict)
    }
}

