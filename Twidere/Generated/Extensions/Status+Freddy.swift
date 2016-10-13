// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Status: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self._id = -1
        self.accountKey = try value.decode(at: "account_key")
        self.sortId = try value.decode(at: "sort_id")
        self.positionKey = try value.decode(at: "position_key")
        self.isGap = try value.decode(at: "is_gap")
        self.createdAt = try value.decode(at: "created_at")
        self.id = try value.decode(at: "status_id")
        self.userKey = try value.decode(at: "user_key")
        self.userName = try value.decode(at: "user_name")
        self.userScreenName = try value.decode(at: "user_screen_name")
        self.userProfileImage = try value.decode(at: "user_profile_image")
        self.textPlain = try value.decode(at: "text_plain")
        self.textDisplay = try value.decode(at: "text_display")
        self.metadata = try? value.decode(at: "metadata")
        self.quotedId = try? value.decode(at: "quoted_status_id")
        self.quotedCreatedAt = try? value.decode(at: "quoted_created_at")
        self.quotedUserKey = try? value.decode(at: "quoted_user_key")
        self.quotedUserName = try? value.decode(at: "quoted_user_name")
        self.quotedUserScreenName = try? value.decode(at: "quoted_user_screen_name")
        self.quotedUserProfileImage = try? value.decode(at: "quoted_user_profile_image")
        self.quotedTextPlain = try? value.decode(at: "quoted_text_plain")
        self.quotedTextDisplay = try? value.decode(at: "quoted_text_display")
        self.quotedMetadata = try? value.decode(at: "quoted_metadata")
        self.retweetedByUserKey = try? value.decode(at: "retweeted_by_user_key")
        self.retweetedByUserName = try? value.decode(at: "retweeted_by_user_name")
        self.retweetedByUserScreenName = try? value.decode(at: "retweeted_by_user_screen_name")
        self.retweetedByUserProfileImage = try? value.decode(at: "retweeted_by_user_profile_image")
        self.retweetId = try? value.decode(at: "retweet_id")
        self.retweetCreatedAt = try? value.decode(at: "retweet_created_at")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["account_key"] = self.accountKey.toJSON()
        dict["sort_id"] = self.sortId.toJSON()
        dict["position_key"] = self.positionKey.toJSON()
        dict["is_gap"] = self.isGap.toJSON()
        dict["created_at"] = self.createdAt.toJSON()
        dict["status_id"] = self.id.toJSON()
        dict["user_key"] = self.userKey.toJSON()
        dict["user_name"] = self.userName.toJSON()
        dict["user_screen_name"] = self.userScreenName.toJSON()
        dict["user_profile_image"] = self.userProfileImage.toJSON()
        dict["text_plain"] = self.textPlain.toJSON()
        dict["text_display"] = self.textDisplay.toJSON()
        return .dictionary(dict)
    }
}

extension Status.Metadata: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.links = try? value.getArray(at: "links").map(LinkSpanItem.init)
        self.mentions = try? value.getArray(at: "mentions").map(MentionSpanItem.init)
        self.hashtags = try? value.getArray(at: "hashtags").map(HashtagSpanItem.init)
        self.media = try? value.getArray(at: "media").map(MediaItem.init)
        self.displayRange = try? value.getArray(at: "display_range").map(Int.init)
        self.inReplyTo = try? value.decode(at: "in_reply_to")
        self.externalUrl = try? value.decode(at: "extenral_url")
        self.replyCount = try? value.decode(at: "reply_count")
        self.retweetCount = try? value.decode(at: "retweet_count")
        self.favoriteCount = try? value.decode(at: "favorite_count")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]

        return .dictionary(dict)
    }
}

extension Status.Metadata.InReplyTo: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.statusId = try value.decode(at: "status_id")
        self.userKey = try value.decode(at: "user_key")
        self.userName = try? value.decode(at: "user_name")
        self.userScreenName = try value.decode(at: "user_screen_name")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["status_id"] = self.statusId.toJSON()
        dict["user_key"] = self.userKey.toJSON()
        dict["user_screen_name"] = self.userScreenName.toJSON()
        return .dictionary(dict)
    }
}


