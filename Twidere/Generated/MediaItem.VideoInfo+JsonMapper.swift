// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaItem.VideoInfo: JsonMappable {

}

internal class MediaItemVideoInfoJsonMapper: JsonMapper<MediaItem.VideoInfo> {

    internal static let singleton = MediaItemVideoInfoJsonMapper()

    override func parse(_ parser: JsonParser) -> MediaItem.VideoInfo! {
        let instance = MediaItem.VideoInfo()
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

    override func parseField(_ instance: MediaItem.VideoInfo, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
