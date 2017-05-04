// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension UrlEntity: JsonMappable {

}

internal class UrlEntityJsonMapper: JsonMapper<UrlEntity> {

    internal static let singleton = UrlEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> UrlEntity! {
        let instance = UrlEntity()
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

    override func parseField(_ instance: UrlEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "url":
            instance.url = parser.getValueAsString()
        case "display_url":
            instance.displayUrl = parser.getValueAsString()
        case "expanded_url":
            instance.expandedUrl = parser.getValueAsString()
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
