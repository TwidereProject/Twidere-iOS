// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension User: JsonMappable {

}

public class UserJsonMapper: JsonMapper<User> {

    public static let singleton = UserJsonMapper()

    override public func parse(_ parser: JsonParser) -> User! {
        let instance = User()
        if (parser.currentEvent == nil) {
            parser.nextEvent()
        }

        if (parser.currentEvent != .objectStart) {
            parser.skipChildren()
            return nil
        }

        while (parser.nextEvent() != .objectEnd) {
            let fieldName = parser.currentName!
            parser.nextEvent()
            parseField(instance, fieldName, parser)
            parser.skipChildren()
        }
        return instance
    }

    override public func parseField(_ instance: User, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        case "unique_id":
            instance.uniqueId = parser.getValueAsString()
        case "created_at":
            instance.createdAt = TwitterDateFieldConverter.parse(parser)
        case "name":
            instance.name = parser.getValueAsString()
        case "screen_name":
            instance.screenName = parser.getValueAsString()
        case "location":
            instance.location = parser.getValueAsString()
        case "description":
            instance.description = parser.getValueAsString()
        case "url":
            instance.url = parser.getValueAsString()
        case "entities":
            instance.entities = UserEntitiesJsonMapper.singleton.parse(parser)
        case "protected":
            instance.isProtected = parser.getValueAsBool()
        case "followers_count":
            instance.followersCount = parser.getValueAsInt64()
        case "friends_count":
            instance.friendsCount = parser.getValueAsInt64()
        case "listed_count":
            instance.listedCount = parser.getValueAsInt64()
        case "groups_count":
            instance.groupsCount = parser.getValueAsInt64()
        case "favourites_count":
            instance.favouritesCount = parser.getValueAsInt64()
        case "utc_offset":
            instance.utcOffset = parser.getValueAsInt32()
        case "time_zone":
            instance.timeZone = parser.getValueAsString()
        case "geo_enabled":
            instance.geoEnabled = parser.getValueAsBool()
        case "verified":
            instance.isVerified = parser.getValueAsBool()
        case "statuses_count":
            instance.statusesCount = parser.getValueAsInt64()
        case "media_count", "photo_count":
            instance.mediaCount = parser.getValueAsInt64()
        case "lang":
            instance.lang = parser.getValueAsString()
        case "status":
            instance.status = StatusJsonMapper.singleton.parse(parser)
        case "contributors_enabled":
            instance.contributorsEnabled = parser.getValueAsBool()
        case "is_translator":
            instance.isTranslator = parser.getValueAsBool()
        case "is_translation_enabled":
            instance.isTranslationEnabled = parser.getValueAsBool()
        case "profile_background_color", "backgroundcolor":
            instance.profileBackgroundColor = parser.getValueAsString()
        case "profile_background_image_url":
            instance.profileBackgroundImageUrl = parser.getValueAsString()
        case "profile_background_image_url_https":
            instance.profileBackgroundImageUrlHttps = parser.getValueAsString()
        case "profile_background_tile":
            instance.profileBackgroundTile = parser.getValueAsBool()
        case "profile_image_url":
            instance.profileImageUrl = parser.getValueAsString()
        case "profile_image_url_https":
            instance.profileImageUrlHttps = parser.getValueAsString()
        case "profile_image_url_large", "profile_image_url_profile_size":
            instance.profileImageUrlLarge = parser.getValueAsString()
        case "profile_banner_url", "cover_photo":
            instance.profileBannerUrl = parser.getValueAsString()
        case "profile_link_color", "linkcolor":
            instance.profileLinkColor = parser.getValueAsString()
        case "profile_sidebar_border_color":
            instance.profileSidebarBorderColor = parser.getValueAsString()
        case "profile_sidebar_fill_color":
            instance.profileSidebarFillColor = parser.getValueAsString()
        case "profile_text_color":
            instance.profileTextColor = parser.getValueAsString()
        case "profile_use_background_image":
            instance.profileUseBackgroundImage = parser.getValueAsBool()
        case "default_profile":
            instance.defaultProfile = parser.getValueAsBool()
        case "default_profile_image":
            instance.defaultProfileImage = parser.getValueAsBool()
        case "has_custom_timelines":
            instance.hasCustomTimelines = parser.getValueAsBool()
        case "suspended":
            instance.isSuspended = parser.getValueAsBool()
        case "needs_phone_verification":
            instance.needsPhoneVerification = parser.getValueAsBool()
        case "statusnet_profile_url":
            instance.statusnetProfileUrl = parser.getValueAsString()
        case "ostatus_uri":
            instance.ostatusUri = parser.getValueAsString()
        case "profile_image_url_original":
            instance.profileImageUrlOriginal = parser.getValueAsString()
        case "pinned_tweet_ids":
            if (parser.currentEvent == .arrayStart) {
                var array: [String] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsString())
                }
                instance.pinnedTweetIds = array
            } else {
                instance.pinnedTweetIds = nil
            }
        case "followed_by", "follows_you":
            instance.followedBy = parser.getValueAsBool()
        case "following":
            instance.following = parser.getValueAsBool()
        case "blocked_by", "blocks_you":
            instance.blockedBy = parser.getValueAsBool()
        case "blocking", "statusnet_blocking":
            instance.blocking = parser.getValueAsBool()
        case "muting":
            instance.muting = parser.getValueAsBool()
        case "follow_request_sent":
            instance.followRequestSent = parser.getValueAsBool()
        case "notifications":
            instance.notificationsEnabled = parser.getValueAsBool()
        case "can_media_tag":
            instance.canMediaTag = parser.getValueAsBool()
        default:
            break
        }
    }
}
