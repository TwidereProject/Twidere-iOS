// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MediaItem: JsonMappable {

}

public class MediaItemJsonMapper: JsonMapper<MediaItem> {

    public static let singleton = MediaItemJsonMapper()

    override public func parse(_ parser: JsonParser) -> MediaItem! {
        let instance = MediaItem()
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

    override public func parseField(_ instance: MediaItem, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "url":
            instance.url = parser.getValueAsString()
        case "media_url":
            instance.mediaUrl = parser.getValueAsString()
        case "preview_url":
            instance.previewUrl = parser.getValueAsString()
        case "type":
            instance.type = MediaItemTypeFieldConverter.parse(parser)
        case "width":
            instance.width = parser.getValueAsInt()
        case "height":
            instance.height = parser.getValueAsInt()
        case "video_info":
            instance.videoInfo = MediaItemVideoInfoJsonMapper.singleton.parse(parser)
        case "page_url":
            instance.pageUrl = parser.getValueAsString()
        case "open_browser":
            instance.openBrowser = parser.getValueAsBool()
        case "alt_text":
            instance.altText = parser.getValueAsString()
        default:
            break
        }
    }
}
