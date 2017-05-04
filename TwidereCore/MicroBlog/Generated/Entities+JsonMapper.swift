// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Entities: JsonMappable {

}

internal class EntitiesJsonMapper: JsonMapper<Entities> {

    internal static let singleton = EntitiesJsonMapper()

    override func parse(_ parser: JsonParser) -> Entities! {
        let instance = Entities()
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

    override func parseField(_ instance: Entities, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "urls":
            if (parser.currentEvent == .arrayStart) {
                var array: [UrlEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(UrlEntityJsonMapper.singleton.parse(parser))
                }
                instance.urls = array
            } else {
                instance.urls = nil
            }
        case "hashtags":
            if (parser.currentEvent == .arrayStart) {
                var array: [HashtagEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(HashtagEntityJsonMapper.singleton.parse(parser))
                }
                instance.hashtags = array
            } else {
                instance.hashtags = nil
            }
        case "mentions":
            if (parser.currentEvent == .arrayStart) {
                var array: [UserMentionEntity] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(UserMentionEntityJsonMapper.singleton.parse(parser))
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
