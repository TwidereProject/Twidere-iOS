// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableStatus: JsonMappable {

}

public class PersistableStatusJsonMapper: JsonMapper<PersistableStatus> {

    public static let singleton = PersistableStatusJsonMapper()

    override public func parse(_ parser: JsonParser) -> PersistableStatus! {
        let instance = PersistableStatus()
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

    override public func parseField(_ instance: PersistableStatus, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        case "account_key":
            instance.account_key = UserKeyFieldConverter.parse(parser)
        case "sort_id":
            instance.sort_id = parser.getValueAsInt64()
        case "position_key":
            instance.position_key = parser.getValueAsInt64()
        case "timestamp":
            instance.timestamp = parser.getValueAsInt64()
        case "user_key":
            instance.user_key = UserKeyFieldConverter.parse(parser)
        case "retweet_id":
            instance.retweet_id = parser.getValueAsString()
        case "retweeted_by_user_key":
            instance.retweeted_by_user_key = UserKeyFieldConverter.parse(parser)
        case "retweet_timestamp":
            instance.retweet_timestamp = parser.getValueAsInt64()
        case "retweet_count":
            instance.retweet_count = parser.getValueAsInt64()
        case "favorite_count":
            instance.favorite_count = parser.getValueAsInt64()
        case "reply_count":
            instance.reply_count = parser.getValueAsInt64()
        case "in_reply_to_status_id":
            instance.in_reply_to_status_id = parser.getValueAsString()
        case "in_reply_to_user_key":
            instance.in_reply_to_user_key = UserKeyFieldConverter.parse(parser)
        case "my_retweet_id":
            instance.my_retweet_id = parser.getValueAsString()
        case "quoted_id":
            instance.quoted_id = parser.getValueAsString()
        case "quoted_timestamp":
            instance.quoted_timestamp = parser.getValueAsInt64()
        case "quoted_user_key":
            instance.quoted_user_key = UserKeyFieldConverter.parse(parser)
        case "is_gap":
            instance.is_gap = parser.getValueAsBool()
        case "is_retweet":
            instance.is_retweet = parser.getValueAsBool()
        case "retweeted":
            instance.retweeted = parser.getValueAsBool()
        case "is_favorite":
            instance.is_favorite = parser.getValueAsBool()
        case "is_possibly_sensitive":
            instance.is_possibly_sensitive = parser.getValueAsBool()
        case "user_is_following":
            instance.user_is_following = parser.getValueAsBool()
        case "user_is_protected":
            instance.user_is_protected = parser.getValueAsBool()
        case "user_is_verified":
            instance.user_is_verified = parser.getValueAsBool()
        case "is_quote":
            instance.is_quote = parser.getValueAsBool()
        case "quoted_user_is_protected":
            instance.quoted_user_is_protected = parser.getValueAsBool()
        case "quoted_user_is_verified":
            instance.quoted_user_is_verified = parser.getValueAsBool()
        case "retweeted_by_user_name":
            instance.retweeted_by_user_name = parser.getValueAsString()
        case "retweeted_by_user_screen_name":
            instance.retweeted_by_user_screen_name = parser.getValueAsString()
        case "retweeted_by_user_profile_image":
            instance.retweeted_by_user_profile_image = parser.getValueAsString()
        case "text_plain":
            instance.text_plain = parser.getValueAsString()
        case "lang":
            instance.lang = parser.getValueAsString()
        case "user_name":
            instance.user_name = parser.getValueAsString()
        case "user_screen_name":
            instance.user_screen_name = parser.getValueAsString()
        case "in_reply_to_name":
            instance.in_reply_to_name = parser.getValueAsString()
        case "in_reply_to_screen_name":
            instance.in_reply_to_screen_name = parser.getValueAsString()
        case "source":
            instance.source = parser.getValueAsString()
        case "user_profile_image_url":
            instance.user_profile_image_url = parser.getValueAsString()
        case "text_unescaped":
            instance.text_unescaped = parser.getValueAsString()
        case "card_name":
            instance.card_name = parser.getValueAsString()
        case "quoted_text_plain":
            instance.quoted_text_plain = parser.getValueAsString()
        case "quoted_text_unescaped":
            instance.quoted_text_unescaped = parser.getValueAsString()
        case "quoted_source":
            instance.quoted_source = parser.getValueAsString()
        case "quoted_user_name":
            instance.quoted_user_name = parser.getValueAsString()
        case "quoted_user_screen_name":
            instance.quoted_user_screen_name = parser.getValueAsString()
        case "quoted_user_profile_image":
            instance.quoted_user_profile_image = parser.getValueAsString()
        case "location":
            instance.location = GeoLocationFieldConverter.parse(parser)
        case "place_full_name":
            instance.place_full_name = parser.getValueAsString()
        case "mentions":
            if (parser.currentEvent == .arrayStart) {
                var array: [MentionItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(MentionItemJsonMapper.singleton.parse(parser))
                }
                instance.mentions = array
            } else {
                instance.mentions = nil
            }
        case "media":
            if (parser.currentEvent == .arrayStart) {
                var array: [MediaItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(MediaItemJsonMapper.singleton.parse(parser))
                }
                instance.media = array
            } else {
                instance.media = nil
            }
        case "quoted_media":
            if (parser.currentEvent == .arrayStart) {
                var array: [MediaItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(MediaItemJsonMapper.singleton.parse(parser))
                }
                instance.quoted_media = array
            } else {
                instance.quoted_media = nil
            }
        case "card":
            instance.card = PersistableCardEntityJsonMapper.singleton.parse(parser)
        case "extras":
            instance.extras = PersistableStatusExtrasJsonMapper.singleton.parse(parser)
        case "spans":
            if (parser.currentEvent == .arrayStart) {
                var array: [SpanItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(SpanItemJsonMapper.singleton.parse(parser))
                }
                instance.spans = array
            } else {
                instance.spans = nil
            }
        case "quoted_spans":
            if (parser.currentEvent == .arrayStart) {
                var array: [SpanItem] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(SpanItemJsonMapper.singleton.parse(parser))
                }
                instance.quoted_spans = array
            } else {
                instance.quoted_spans = nil
            }
        case "account_color":
            instance.account_color = parser.getValueAsInt()
        default:
            break
        }
    }
}
