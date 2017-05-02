// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MicroBlogStatus {

    static func parse(parser: PMJacksonParser) -> MicroBlogStatus! {
        let instance = MicroBlogStatus()
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

    private static func parseField(_ instance: MicroBlogStatus, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
                    case "created_at": instance.createdAt = Date.parseTwitterDate(parser)
                    case "id": instance.id = parser.getValueAsString()
                    case "rawid": instance.rawId = parser.getValueAsInt64()
                    case "text": instance.text = parser.getValueAsString()
                    case "full_text": instance.fullText = parser.getValueAsString()
                    case "statusnet_html": instance.statusnetHtml = parser.getValueAsString()
                    case "source": instance.source = parser.getValueAsString()
                    case "truncated": instance.truncated = parser.getValueAsBool()
                    case "entities": instance.entities = TwitterEntities.parse(parser: parser)
                    case "extended_entities": instance.extendedEntities = TwitterEntities.parse(parser: parser)
                    case "in_reply_to_status_id": instance.inReplyToStatusId = parser.getValueAsString()
                    case "in_reply_to_user_id": instance.inReplyToUserId = parser.getValueAsString()
                    case "in_reply_to_screen_name": instance.inReplyToScreenName = parser.getValueAsString()
                    case "user": instance.user = MicroBlogUser.parse(parser: parser)
                    case "geo": instance.geo = MicroBlogGeoPoint.parse(parser: parser)
                    case "place": instance.place = MicroBlogPlace.parse(parser: parser)
                    case "current_user_retweet": instance.currentUserRetweet = CurrentUserRetweet.parse(parser: parser)
                    case "retweet_count", "repeat_num": instance.retweetCount = parser.getValueAsInt64()
                    case "favorite_count", "fave_num": instance.favoriteCount = parser.getValueAsInt64()
                    case "reply_count": instance.replyCount = parser.getValueAsInt64()
                    case "favorited": instance.favorited = parser.getValueAsBool()
                    case "retweeted", "repeated": instance.retweeted = parser.getValueAsBool()
                    case "lang": instance.lang = parser.getValueAsString()
                    case "descendent_reply_count": instance.descendentReplyCount = parser.getValueAsInt64()
                    case "retweeted_status": instance.retweetedStatus = MicroBlogStatus.parse(parser: parser)
                    case "quoted_status", "repost_status": instance.quotedStatus = MicroBlogStatus.parse(parser: parser)
                    case "quoted_status_id_str", "repost_status_id": instance.quotedStatusId = parser.getValueAsString()
                    case "is_quote_status": instance.isQuoteStatus = parser.getValueAsBool()
                    case "card": instance.card = TwitterCardEntity.parse(parser: parser)
                    case "possibly_sensitive": instance.possiblySensitive = parser.getValueAsBool()
                    case "attachments":
            if (parser.currentEvent == .arrayStart) {
                var array = [GNUSocialAttachment]()
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(GNUSocialAttachment.parse(parser: parser))
                }
                instance.attachments = array
            } else {
                instance.attachments = nil
            }
                    case "external_url": instance.externalUrl = parser.getValueAsString()
                    case "conversation_id", "statusnet_conversation_id": instance.conversationId = parser.getValueAsString()
                    case "attentions":
            if (parser.currentEvent == .arrayStart) {
                var array = [GNUSocialAttention]()
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(GNUSocialAttention.parse(parser: parser))
                }
                instance.attentions = array
            } else {
                instance.attentions = nil
            }
                    case "photo": instance.photo = FanfouPhoto.parse(parser: parser)
                    case "location": instance.location = parser.getValueAsString()
                    case "display_text_range":
            if (parser.currentEvent == .arrayStart) {
                var array = [Int32]()
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsInt32())
                }
                instance.displayTextRange = array
            } else {
                instance.displayTextRange = nil
            }
                    case "uri": instance.uri = parser.getValueAsString()
                    case "timestamp_ms": instance.timestampMs = parser.getValueAsInt64()
                    case "extended_tweet": instance.extendedTweet = ExtendedTweet.parse(parser: parser)
        default: break
        }
    }
}
