// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaUploadResponse.ProcessingInfo: JsonMappable {

}

public class MediaUploadResponseProcessingInfoJsonMapper: JsonMapper<MediaUploadResponse.ProcessingInfo> {

    public static let singleton = MediaUploadResponseProcessingInfoJsonMapper()

    override public func parse(_ parser: JsonParser) -> MediaUploadResponse.ProcessingInfo! {
        let instance = MediaUploadResponse.ProcessingInfo()
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

    override public func parseField(_ instance: MediaUploadResponse.ProcessingInfo, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
