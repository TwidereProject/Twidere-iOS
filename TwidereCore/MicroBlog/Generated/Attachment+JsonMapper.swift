// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Attachment: JsonMappable {

}

internal class AttachmentJsonMapper: JsonMapper<Attachment> {

    internal static let singleton = AttachmentJsonMapper()

    override func parse(_ parser: JsonParser) -> Attachment! {
        let instance = Attachment()
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

    override func parseField(_ instance: Attachment, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "width":
            instance.width = parser.getValueAsInt32()
        case "height":
            instance.height = parser.getValueAsInt32()
        case "url":
            instance.url = parser.getValueAsString()
        case "thumb_url":
            instance.thumbUrl = parser.getValueAsString()
        case "large_thumb_url":
            instance.largeThumbUrl = parser.getValueAsString()
        case "mimetype":
            instance.mimetype = parser.getValueAsString()
        case "id":
            instance.id = parser.getValueAsInt64()
        case "oembed":
            instance.oembed = parser.getValueAsBool()
        case "size":
            instance.size = parser.getValueAsInt64()
        case "version":
            instance.version = parser.getValueAsString()
        default:
            break
        }
    }
}
