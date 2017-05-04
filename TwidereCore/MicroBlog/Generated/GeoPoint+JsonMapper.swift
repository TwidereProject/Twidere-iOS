// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension GeoPoint: JsonMappable {

}

public class GeoPointJsonMapper: JsonMapper<GeoPoint> {

    public static let singleton = GeoPointJsonMapper()

    override public func parse(_ parser: JsonParser) -> GeoPoint! {
        let instance = GeoPoint()
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

    override public func parseField(_ instance: GeoPoint, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "coordinates":
            if (parser.currentEvent == .arrayStart) {
                var array: [Double] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsDouble())
                }
                instance.coordinates = array
            } else {
                instance.coordinates = nil
            }
        case "type":
            instance.type = parser.getValueAsString()
        default:
            break
        }
    }
}
