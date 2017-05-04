// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Place: JsonMappable {

}

internal class PlaceJsonMapper: JsonMapper<Place> {

    internal static let singleton = PlaceJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> Place! {
        let instance = Place()
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

    override func parseField(_ instance: Place, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "full_name":
            instance.fullName = parser.getValueAsString()
        default:
            break
        }
    }
}
