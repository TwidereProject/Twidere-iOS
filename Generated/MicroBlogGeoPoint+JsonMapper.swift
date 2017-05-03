// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MicroBlogGeoPoint: JsonMappable {

}

internal class MicroBlogGeoPointJsonMapper: JsonMapper<MicroBlogGeoPoint> {

    internal static let singleton = MicroBlogGeoPointJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> MicroBlogGeoPoint! {
        let instance = MicroBlogGeoPoint()
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

    override func parseField(_ instance: MicroBlogGeoPoint, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "coordinates":
            if (parser.currentEvent == .arrayStart) {
                var array = [Double]()
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
