// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Place: JsonMappable {

}

public class PlaceJsonMapper: JsonMapper<Place> {

    public static let singleton = PlaceJsonMapper()

    override public func parse(_ parser: JsonParser) -> Place! {
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

    override public func parseField(_ instance: Place, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "full_name":
            instance.fullName = parser.getValueAsString()
        default:
            break
        }
    }
}
