// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension HashtagEntity: JsonMappable {

}

internal class HashtagEntityJsonMapper: JsonMapper<HashtagEntity> {

    internal static let singleton = HashtagEntityJsonMapper()

    override func parse(_ parser: JsonParser) -> HashtagEntity! {
        let instance = HashtagEntity()
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

    override func parseField(_ instance: HashtagEntity, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "text":
            instance.text = parser.getValueAsString()
        case "indices":
            if (parser.currentEvent == .arrayStart) {
                var array: [Int32] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsInt32())
                }
                instance.indices = array
            } else {
                instance.indices = nil
            }
        default:
            break
        }
    }
}
