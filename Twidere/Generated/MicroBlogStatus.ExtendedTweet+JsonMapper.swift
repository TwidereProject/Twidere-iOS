// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MicroBlogStatus.ExtendedTweet: JsonMappable {

}

internal class MicroBlogStatusExtendedTweetJsonMapper: JsonMapper<MicroBlogStatus.ExtendedTweet> {

    internal static let singleton = MicroBlogStatusExtendedTweetJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> MicroBlogStatus.ExtendedTweet! {
        let instance = MicroBlogStatus.ExtendedTweet()
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

    override func parseField(_ instance: MicroBlogStatus.ExtendedTweet, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "full_text":
            instance.fullText = parser.getValueAsString()
        case "entities":
            instance.entities = TwitterEntitiesJsonMapper.singleton.parse(parser)
        case "extended_entities":
            instance.extendedEntities = TwitterEntitiesJsonMapper.singleton.parse(parser)
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
        default:
            break
        }
    }
}
