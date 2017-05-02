// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension TwitterEntities {

    internal static func parse(_ instance: TwitterEntities = TwitterEntities(), parser: PMJacksonParser) -> TwitterEntities! {
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

    internal static func parseField(_ instance: TwitterEntities, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "urls":
            if (parser.currentEvent == .arrayStart) {
                var array = [TwitterURLEntity]()
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(TwitterURLEntity.parse(parser: parser))
                }
                instance.urls = array
            } else {
                instance.urls = nil
            }
        case "hashtags":
            if (parser.currentEvent == .arrayStart) {
                var array = [TwitterHashtagEntity]()
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(TwitterHashtagEntity.parse(parser: parser))
                }
                instance.hashtags = array
            } else {
                instance.hashtags = nil
            }
        default:
            break
        }
    }
}
