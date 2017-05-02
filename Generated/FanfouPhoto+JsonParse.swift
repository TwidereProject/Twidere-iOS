// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension FanfouPhoto {

    typealias T = FanfouPhoto

    internal static func parse(_ instance: FanfouPhoto = FanfouPhoto(), parser: PMJacksonParser) -> FanfouPhoto! {
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

    internal static func parseField(_ instance: FanfouPhoto, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "url":
            instance.url = parser.getValueAsString()
        case "imageurl":
            instance.imageUrl = parser.getValueAsString()
        case "thumburl":
            instance.thumbUrl = parser.getValueAsString()
        case "largeurl":
            instance.largeUrl = parser.getValueAsString()
        default:
            break
        }
    }
}
