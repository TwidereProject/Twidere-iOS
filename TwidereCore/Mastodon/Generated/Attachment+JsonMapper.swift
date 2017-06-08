// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Attachment: JsonMappable {

}

public class AttachmentJsonMapper: JsonMapper<Attachment> {

    public static let singleton = AttachmentJsonMapper()

    override public func parse(_ parser: JsonParser) -> Attachment! {
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

    override public func parseField(_ instance: Attachment, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        case "type":
            instance.type = parser.getValueAsString()
        case "url":
            instance.url = parser.getValueAsString()
        case "remote_url":
            instance.remoteUrl = parser.getValueAsString()
        case "preview_url":
            instance.previewUrl = parser.getValueAsString()
        case "text_url":
            instance.textUrl = parser.getValueAsString()
        default:
            break
        }
    }
}
