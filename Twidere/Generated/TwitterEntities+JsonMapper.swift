// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension TwitterEntities: JsonMappable {

}

internal class TwitterEntitiesJsonMapper: JsonMapper<TwitterEntities> {

    internal static let singleton = TwitterEntitiesJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterEntities! {
        let instance = TwitterEntities()
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

    override func parseField(_ instance: TwitterEntities, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "urls":
            if (parser.currentEvent == .arrayStart) {
                var array: [TwitterURLEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(TwitterURLEntityJsonMapper.singleton.parse(parser))
                }
                instance.urls = array
            } else {
                instance.urls = nil
            }
        case "hashtags":
            if (parser.currentEvent == .arrayStart) {
                var array: [TwitterHashtagEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(TwitterHashtagEntityJsonMapper.singleton.parse(parser))
                }
                instance.hashtags = array
            } else {
                instance.hashtags = nil
            }
        case "mentions":
            if (parser.currentEvent == .arrayStart) {
                var array: [TwitterMentionEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(TwitterMentionEntityJsonMapper.singleton.parse(parser))
                }
                instance.mentions = array
            } else {
                instance.mentions = nil
            }
        default:
            break
        }
    }
}
