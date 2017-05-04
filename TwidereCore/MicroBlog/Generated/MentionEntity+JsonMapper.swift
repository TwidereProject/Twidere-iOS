// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MentionEntity: JsonMappable {

}

internal class MentionEntityJsonMapper: JsonMapper<MentionEntity> {

    internal static let singleton = MentionEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> MentionEntity! {
        let instance = MentionEntity()
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

    override func parseField(_ instance: MentionEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
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
