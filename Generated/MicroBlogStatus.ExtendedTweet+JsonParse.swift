// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension MicroBlogStatus.ExtendedTweet {

    internal static func parse(_ instance: MicroBlogStatus.ExtendedTweet = MicroBlogStatus.ExtendedTweet(), parser: PMJacksonParser) -> MicroBlogStatus.ExtendedTweet! {
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

    internal static func parseField(_ instance: MicroBlogStatus.ExtendedTweet, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "full_text":
            instance.fullText = parser.getValueAsString()
        case "entities":
            instance.entities = TwitterEntities.parse(parser: parser)
        case "extended_entities":
            instance.extendedEntities = TwitterEntities.parse(parser: parser)
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
        default:
            break
        }
    }
}
