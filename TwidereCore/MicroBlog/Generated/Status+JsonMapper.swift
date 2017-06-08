// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson
import RestCommons

extension Status: JsonMappable {

}

public class StatusJsonMapper: JsonMapper<Status> {

    public static let singleton = StatusJsonMapper()

    override public func parse(_ parser: JsonParser) -> Status! {
        let instance = Status()
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

    override public func parseField(_ instance: Status, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "created_at":
            instance.createdAt = JavaScriptDateFieldConverter.parse(parser)
        case "id":
            instance.id = parser.getValueAsString()
        case "rawid":
            instance.rawId = parser.getValueAsInt64()
        case "text":
            instance.text = parser.getValueAsString()
        case "full_text":
            instance.fullText = parser.getValueAsString()
        case "statusnet_html":
            instance.statusnetHtml = parser.getValueAsString()
        case "source":
            instance.source = parser.getValueAsString()
        case "truncated":
            instance.truncated = parser.getValueAsBool()
        case "entities":
            instance.entities = EntitiesJsonMapper.singleton.parse(parser)
        case "extended_entities":
            instance.extendedEntities = EntitiesJsonMapper.singleton.parse(parser)
        case "in_reply_to_status_id":
            instance.inReplyToStatusId = parser.getValueAsString()
        case "in_reply_to_user_id":
            instance.inReplyToUserId = parser.getValueAsString()
        case "in_reply_to_screen_name":
            instance.inReplyToScreenName = parser.getValueAsString()
        case "user":
            instance.user = UserJsonMapper.singleton.parse(parser)
        case "geo":
            instance.geo = GeoPointJsonMapper.singleton.parse(parser)
        case "place":
            instance.place = PlaceJsonMapper.singleton.parse(parser)
        case "current_user_retweet":
            instance.currentUserRetweet = StatusCurrentUserRetweetJsonMapper.singleton.parse(parser)
        case "retweet_count", "repeat_num":
            instance.retweetCount = parser.getValueAsInt64()
        case "favorite_count", "fave_num":
            instance.favoriteCount = parser.getValueAsInt64()
        case "reply_count":
            instance.replyCount = parser.getValueAsInt64()
        case "favorited":
            instance.favorited = parser.getValueAsBool()
        case "retweeted", "repeated":
            instance.retweeted = parser.getValueAsBool()
        case "lang":
            instance.lang = parser.getValueAsString()
        case "descendent_reply_count":
            instance.descendentReplyCount = parser.getValueAsInt64()
        case "retweeted_status":
            instance.retweetedStatus = StatusJsonMapper.singleton.parse(parser)
        case "quoted_status", "repost_status":
            instance.quotedStatus = StatusJsonMapper.singleton.parse(parser)
        case "quoted_status_id_str", "repost_status_id":
            instance.quotedStatusId = parser.getValueAsString()
        case "is_quote_status":
            instance.isQuoteStatus = parser.getValueAsBool()
        case "card":
            instance.card = CardEntityJsonMapper.singleton.parse(parser)
        case "possibly_sensitive":
            instance.possiblySensitive = parser.getValueAsBool()
        case "attachments":
            if (parser.currentEvent == .arrayStart) {
                var array: [Attachment] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(AttachmentJsonMapper.singleton.parse(parser))
                }
                instance.attachments = array
            } else {
                instance.attachments = nil
            }
        case "external_url":
            instance.externalUrl = parser.getValueAsString()
        case "statusnet_conversation_id":
            instance.statusnetConversationId = parser.getValueAsString()
        case "conversation_id", "statusnet_conversation_id":
            instance.conversationId = parser.getValueAsString()
        case "attentions":
            if (parser.currentEvent == .arrayStart) {
                var array: [Attention] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(AttentionJsonMapper.singleton.parse(parser))
                }
                instance.attentions = array
            } else {
                instance.attentions = nil
            }
        case "photo":
            instance.photo = PhotoJsonMapper.singleton.parse(parser)
        case "location":
            instance.location = parser.getValueAsString()
        case "display_text_range":
            if (parser.currentEvent == .arrayStart) {
                var array: [Int] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsInt())
                }
                instance.displayTextRange = array
            } else {
                instance.displayTextRange = nil
            }
        case "uri":
            instance.uri = parser.getValueAsString()
        case "timestamp_ms":
            instance.timestampMs = parser.getValueAsInt64()
        case "extended_tweet":
            instance.extendedTweet = StatusExtendedTweetJsonMapper.singleton.parse(parser)
        default:
            break
        }
    }
}
