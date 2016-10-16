// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Status: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status {
        let accountKey: UserKey = try value.decode(at: "account_key")
        let sortId: Int64 = try value.decode(at: "sort_id")
        let positionKey: Int64 = try value.decode(at: "position_key")
        let isGap: Bool = try value.decode(at: "is_gap")
        let createdAt: Date = try value.decode(at: "created_at")
        let id: String = try value.decode(at: "status_id")
        let userKey: UserKey = try value.decode(at: "user_key")
        let userName: String = try value.decode(at: "user_name")
        let userScreenName: String = try value.decode(at: "user_screen_name")
        let userProfileImage: String = try value.decode(at: "user_profile_image")
        let textPlain: String = try value.decode(at: "text_plain")
        let textDisplay: String = try value.decode(at: "text_display")
        let metadata: Metadata = try value.decode(at: "metadata")
        let quotedId: String = try value.decode(at: "quoted_status_id")
        let quotedCreatedAt: Date = try value.decode(at: "quoted_created_at")
        let quotedUserKey: UserKey = try value.decode(at: "quoted_user_key")
        let quotedUserName: String = try value.decode(at: "quoted_user_name")
        let quotedUserScreenName: String = try value.decode(at: "quoted_user_screen_name")
        let quotedUserProfileImage: String = try value.decode(at: "quoted_user_profile_image")
        let quotedTextPlain: String = try value.decode(at: "quoted_text_plain")
        let quotedTextDisplay: String = try value.decode(at: "quoted_text_display")
        let quotedMetadata: Metadata = try value.decode(at: "quoted_metadata")
        let retweetedByUserKey: UserKey = try value.decode(at: "retweeted_by_user_key")
        let retweetedByUserName: String = try value.decode(at: "retweeted_by_user_name")
        let retweetedByUserScreenName: String = try value.decode(at: "retweeted_by_user_screen_name")
        let retweetedByUserProfileImage: String = try value.decode(at: "retweeted_by_user_profile_image")
        let retweetId: String = try value.decode(at: "retweet_id")
        let retweetCreatedAt: Date = try value.decode(at: "retweet_created_at")
        return Status(accountKey: accountKey, sortId: sortId, positionKey: positionKey, isGap: isGap, createdAt: createdAt, id: id, userKey: userKey, userName: userName, userScreenName: userScreenName, userProfileImage: userProfileImage, textPlain: textPlain, textDisplay: textDisplay, metadata: metadata, quotedId: quotedId, quotedCreatedAt: quotedCreatedAt, quotedUserKey: quotedUserKey, quotedUserName: quotedUserName, quotedUserScreenName: quotedUserScreenName, quotedUserProfileImage: quotedUserProfileImage, quotedTextPlain: quotedTextPlain, quotedTextDisplay: quotedTextDisplay, quotedMetadata: quotedMetadata, retweetedByUserKey: retweetedByUserKey, retweetedByUserName: retweetedByUserName, retweetedByUserScreenName: retweetedByUserScreenName, retweetedByUserProfileImage: retweetedByUserProfileImage, retweetId: retweetId, retweetCreatedAt: retweetCreatedAt)
    }

}

extension Status: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}
extension Status.Metadata: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status.Metadata {
        let links: [LinkSpanItem] = try value.decodedArray(at: "links")
        let mentions: [MentionSpanItem] = try value.decodedArray(at: "mentions")
        let hashtags: [HashtagSpanItem] = try value.decodedArray(at: "hashtags")
        let media: [MediaItem] = try value.decodedArray(at: "media")
        let displayRange: [Int] = try value.decodedArray(at: "display_range")
        let inReplyTo: InReplyTo = try value.decode(at: "in_reply_to")
        let externalUrl: String = try value.decode(at: "extenral_url")
        let replyCount: Int64 = try value.decode(at: "reply_count")
        let retweetCount: Int64 = try value.decode(at: "retweet_count")
        let favoriteCount: Int64 = try value.decode(at: "favorite_count")
        return Status.Metadata(links: links, mentions: mentions, hashtags: hashtags, media: media, displayRange: displayRange, inReplyTo: inReplyTo, externalUrl: externalUrl, replyCount: replyCount, retweetCount: retweetCount, favoriteCount: favoriteCount)
    }

}

extension Status.Metadata: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}
extension Status.Metadata.InReplyTo: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Status.Metadata.InReplyTo {
        let statusId: String = try value.decode(at: "status_id")
        let userKey: UserKey = try value.decode(at: "user_key")
        let userName: String = try value.decode(at: "user_name")
        let userScreenName: String = try value.decode(at: "user_screen_name")
        return Status.Metadata.InReplyTo(statusId: statusId, userKey: userKey, userName: userName, userScreenName: userScreenName)
    }

}

extension Status.Metadata.InReplyTo: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

