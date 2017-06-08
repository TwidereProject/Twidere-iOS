// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableUser: JsonMappable {

}

public class PersistableUserJsonMapper: JsonMapper<PersistableUser> {

    public static let singleton = PersistableUserJsonMapper()

    override public func parse(_ parser: JsonParser) -> PersistableUser! {
        let instance = PersistableUser()
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

    override public func parseField(_ instance: PersistableUser, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "account_key":
            instance.account_key = UserKeyFieldConverter.parse(parser)
        case "key":
            instance.key = UserKeyFieldConverter.parse(parser)
        case "created_at":
            instance.created_at = parser.getValueAsInt64()
        case "position":
            instance.position = parser.getValueAsInt64()
        case "is_protected":
            instance.is_protected = parser.getValueAsBool()
        case "is_verified":
            instance.is_verified = parser.getValueAsBool()
        case "is_follow_request_sent":
            instance.is_follow_request_sent = parser.getValueAsBool()
        case "is_following":
            instance.is_following = parser.getValueAsBool()
        case "description_plain":
            instance.description_plain = parser.getValueAsString()
        case "name":
            instance.name = parser.getValueAsString()
        case "screen_name":
            instance.screen_name = parser.getValueAsString()
        case "location":
            instance.location = parser.getValueAsString()
        case "profile_image_url":
            instance.profile_image_url = parser.getValueAsString()
        case "profile_banner_url":
            instance.profile_banner_url = parser.getValueAsString()
        case "profile_background_url":
            instance.profile_background_url = parser.getValueAsString()
        case "url":
            instance.url = parser.getValueAsString()
        case "url_expanded":
            instance.url_expanded = parser.getValueAsString()
        case "description_unescaped":
            instance.description_unescaped = parser.getValueAsString()
        case "description_spans":
            if (parser.currentEvent == .arrayStart) {
                var array: [SpanItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(SpanItemJsonMapper.singleton.parse(parser))
                }
                instance.description_spans = array
            } else {
                instance.description_spans = nil
            }
        case "followers_count":
            instance.followers_count = parser.getValueAsInt64()
        case "friends_count":
            instance.friends_count = parser.getValueAsInt64()
        case "statuses_count":
            instance.statuses_count = parser.getValueAsInt64()
        case "favorites_count":
            instance.favorites_count = parser.getValueAsInt64()
        case "listed_count":
            instance.listed_count = parser.getValueAsInt64()
        case "media_count":
            instance.media_count = parser.getValueAsInt64()
        case "background_color":
            instance.background_color = parser.getValueAsInt()
        case "link_color":
            instance.link_color = parser.getValueAsInt()
        case "text_color":
            instance.text_color = parser.getValueAsInt()
        case "is_cache":
            instance.is_cache = parser.getValueAsBool()
        case "is_basic":
            instance.is_basic = parser.getValueAsBool()
        case "extras":
            instance.extras = PersistableUserExtrasJsonMapper.singleton.parse(parser)
        default:
            break
        }
    }
}
