// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaUploadResponse.Image: JsonMappable {

}

internal class MediaUploadResponseImageJsonMapper: JsonMapper<MediaUploadResponse.Image> {

    internal static let singleton = MediaUploadResponseImageJsonMapper()

    override func parse(_ parser: JsonParser) -> MediaUploadResponse.Image! {
        let instance = MediaUploadResponse.Image()
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

    override func parseField(_ instance: MediaUploadResponse.Image, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
