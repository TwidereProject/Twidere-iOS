// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension TwitterBaseEntity: JsonMappable {

}

internal class TwitterBaseEntityJsonMapper: JsonMapper<TwitterBaseEntity> {

    internal static let singleton = TwitterBaseEntityJsonMapper()

    override func parse(_ instance: TwitterBaseEntity = TwitterBaseEntity(), parser: PMJacksonParser) -> TwitterBaseEntity! {
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

    override func parseField(_ instance: TwitterBaseEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "indices":
            if (parser.currentEvent == .arrayStart) {
                var array = [Int32]()
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
