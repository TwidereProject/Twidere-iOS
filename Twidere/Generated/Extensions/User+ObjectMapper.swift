// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension User: StaticMappable {

    func mapping(map: Map) {
        accountKey <- (map["account_key"], UserKeyTransform())
        key <- (map["user_key"], UserKeyTransform())
        createdAt <- map["created_at"]
        isProtected <- map["is_protected"]
        isVerified <- map["is_verified"]
        name <- map["name"]
        screenName <- map["screen_name"]
        profileImageUrl <- map["profile_image_url"]
        profileBannerUrl <- map["profile_banner_url"]
        profileBackgroundUrl <- map["profile_background_url"]
        descriptionPlain <- map["description_plain"]
        descriptionDisplay <- map["description_display"]
        url <- map["url"]
        urlExpanded <- map["url_expanded"]
        location <- map["location"]
        metadata <- map["metadata"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return User()
    }
}

extension User.Metadata: StaticMappable {

    func mapping(map: Map) {
        following <- map["following"]
        followedBy <- map["followed_by"]
        blocking <- map["blocking"]
        blockedBy <- map["blocked_by"]
        muting <- map["muting"]
        followRequestSent <- map["follow_request_sent"]
        descriptionLinks <- map["description_links"]
        descriptionMentions <- map["description_mentions"]
        descriptionHashtags <- map["description_hashtags"]
        statusesCount <- map["statuses_count"]
        followersCount <- map["followers_count"]
        friendsCount <- map["friends_count"]
        favoritesCount <- map["favorites_count"]
        mediaCount <- map["media_count"]
        listsCount <- map["lists_count"]
        listedCount <- map["listed_count"]
        groupsCount <- map["groups_count"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return User.Metadata()
    }
}


