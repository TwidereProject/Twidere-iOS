// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Photo: JsonMappable {

}

public class PhotoJsonMapper: JsonMapper<Photo> {

    public static let singleton = PhotoJsonMapper()

    override public func parse(_ parser: JsonParser) -> Photo! {
        let instance = Photo()
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

    override public func parseField(_ instance: Photo, _ fieldName: String, _ parser: JsonParser) {
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
