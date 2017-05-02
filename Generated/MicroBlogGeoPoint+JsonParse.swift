// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension MicroBlogGeoPoint {

    typealias T = MicroBlogGeoPoint

    internal static func parse(_ instance: MicroBlogGeoPoint = MicroBlogGeoPoint(), parser: PMJacksonParser) -> MicroBlogGeoPoint! {
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

    internal static func parseField(_ instance: MicroBlogGeoPoint, _ fieldName: String, _ parser: PMJacksonParser) {
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
