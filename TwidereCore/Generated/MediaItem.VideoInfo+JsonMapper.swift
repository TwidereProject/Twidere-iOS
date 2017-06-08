// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaItem.VideoInfo: JsonMappable {

}

public class MediaItemVideoInfoJsonMapper: JsonMapper<MediaItem.VideoInfo> {

    public static let singleton = MediaItemVideoInfoJsonMapper()

    override public func parse(_ parser: JsonParser) -> MediaItem.VideoInfo! {
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

    override public func parseField(_ instance: MediaItem.VideoInfo, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
