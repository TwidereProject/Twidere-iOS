// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaItem.VideoInfo.Variant: JsonMappable {

}

internal class MediaItemVideoInfoVariantJsonMapper: JsonMapper<MediaItem.VideoInfo.Variant> {

    internal static let singleton = MediaItemVideoInfoVariantJsonMapper()

    override internal func parse(_ parser: JsonParser) -> MediaItem.VideoInfo.Variant! {
        let instance = MediaItem.VideoInfo.Variant()
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

    override internal func parseField(_ instance: MediaItem.VideoInfo.Variant, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
