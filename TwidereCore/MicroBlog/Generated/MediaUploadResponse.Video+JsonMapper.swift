// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaUploadResponse.Video: JsonMappable {

}

public class MediaUploadResponseVideoJsonMapper: JsonMapper<MediaUploadResponse.Video> {

    public static let singleton = MediaUploadResponseVideoJsonMapper()

    override public func parse(_ parser: JsonParser) -> MediaUploadResponse.Video! {
        let instance = MediaUploadResponse.Video()
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

    override public func parseField(_ instance: MediaUploadResponse.Video, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
