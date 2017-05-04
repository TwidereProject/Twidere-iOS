// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Status.ExtendedTweet: JsonMappable {

}

public class StatusExtendedTweetJsonMapper: JsonMapper<Status.ExtendedTweet> {

    public static let singleton = StatusExtendedTweetJsonMapper()

    override public func parse(_ parser: JsonParser) -> Status.ExtendedTweet! {
        let instance = Status.ExtendedTweet()
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

    override public func parseField(_ instance: Status.ExtendedTweet, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "full_text":
            instance.fullText = parser.getValueAsString()
        case "entities":
            instance.entities = EntitiesJsonMapper.singleton.parse(parser)
        case "extended_entities":
            instance.extendedEntities = EntitiesJsonMapper.singleton.parse(parser)
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
