// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Attention: JsonMappable {

}

internal class AttentionJsonMapper: JsonMapper<Attention> {

    internal static let singleton = AttentionJsonMapper()

    override func parse(_ parser: JsonParser) -> Attention! {
        let instance = Attention()
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

    override func parseField(_ instance: Attention, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "fullname":
            instance.fullName = parser.getValueAsString()
        case "id":
            instance.id = parser.getValueAsString()
        case "ostatus_uri":
            instance.ostatusUri = parser.getValueAsString()
        case "profileurl":
            instance.profileUrl = parser.getValueAsString()
        case "screen_name":
            instance.screenName = parser.getValueAsString()
        default:
            break
        }
    }
}
