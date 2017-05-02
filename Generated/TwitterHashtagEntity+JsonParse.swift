// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension TwitterHashtagEntity {

    typealias T = TwitterHashtagEntity

    internal static func parse(_ instance: TwitterHashtagEntity = TwitterHashtagEntity(), parser: PMJacksonParser) -> TwitterHashtagEntity! {
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

    internal static func parseField(_ instance: TwitterHashtagEntity, _ fieldName: String, _ parser: PMJacksonParser) {
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
            TwitterBaseEntity.parseField(instance, fieldName, parser)
        }
    }
}
