// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension User: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> User {
        let accountKey: UserKey = try value.decode(at: "account_key")
        let key: UserKey = try value.decode(at: "user_key")
        let createdAt: Date = try value.decode(at: "created_at")
        let isProtected: Bool = try value.decode(at: "is_protected")
        let isVerified: Bool = try value.decode(at: "is_verified")
        let name: String = try value.decode(at: "name")
        let screenName: String = try value.decode(at: "screen_name")
        let profileImageUrl: String = try value.decode(at: "profile_image_url")
        let profileBannerUrl: String = try value.decode(at: "profile_banner_url")
        let profileBackgroundUrl: String = try value.decode(at: "profile_background_url")
        let descriptionPlain: String = try value.decode(at: "description_plain")
        let descriptionDisplay: String = try value.decode(at: "description_display")
        let url: String = try value.decode(at: "url")
        let urlExpanded: String = try value.decode(at: "url_expanded")
        let location: String = try value.decode(at: "location")
        let metadata: Metadata = try value.decode(at: "metadata")
        return User(accountKey: accountKey, key: key, createdAt: createdAt, isProtected: isProtected, isVerified: isVerified, name: name, screenName: screenName, profileImageUrl: profileImageUrl, profileBannerUrl: profileBannerUrl, profileBackgroundUrl: profileBackgroundUrl, descriptionPlain: descriptionPlain, descriptionDisplay: descriptionDisplay, url: url, urlExpanded: urlExpanded, location: location, metadata: metadata)
    }

}

extension User: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}
extension User.Metadata: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> User.Metadata {
        let following: Bool = try value.decode(at: "following")
        let followedBy: Bool = try value.decode(at: "followed_by")
        let blocking: Bool = try value.decode(at: "blocking")
        let blockedBy: Bool = try value.decode(at: "blocked_by")
        let muting: Bool = try value.decode(at: "muting")
        let followRequestSent: Bool = try value.decode(at: "follow_request_sent")
        let descriptionLinks: [LinkSpanItem] = try value.decodedArray(at: "description_links")
        let descriptionMentions: [MentionSpanItem] = try value.decodedArray(at: "description_mentions")
        let descriptionHashtags: [HashtagSpanItem] = try value.decodedArray(at: "description_hashtags")
        let linkColor: String = try value.decode(at: "link_color")
        let backgroundColor: String = try value.decode(at: "background_color")
        let statusesCount: Int64 = try value.decode(at: "statuses_count")
        let followersCount: Int64 = try value.decode(at: "followers_count")
        let friendsCount: Int64 = try value.decode(at: "friends_count")
        let favoritesCount: Int64 = try value.decode(at: "favorites_count")
        let mediaCount: Int64 = try value.decode(at: "media_count")
        let listsCount: Int64 = try value.decode(at: "lists_count")
        let listedCount: Int64 = try value.decode(at: "listed_count")
        let groupsCount: Int64 = try value.decode(at: "groups_count")
        return User.Metadata(following: following, followedBy: followedBy, blocking: blocking, blockedBy: blockedBy, muting: muting, followRequestSent: followRequestSent, descriptionLinks: descriptionLinks, descriptionMentions: descriptionMentions, descriptionHashtags: descriptionHashtags, linkColor: linkColor, backgroundColor: backgroundColor, statusesCount: statusesCount, followersCount: followersCount, friendsCount: friendsCount, favoritesCount: favoritesCount, mediaCount: mediaCount, listsCount: listsCount, listedCount: listedCount, groupsCount: groupsCount)
    }

}

extension User.Metadata: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

