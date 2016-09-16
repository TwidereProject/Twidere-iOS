// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension MediaItem: StaticMappable {

    func mapping(map: Map) {
        url <- map["url"]
        mediaUrl <- map["media_url"]
        previewUrl <- map["preview_url"]
        type <- map["type"]
        width <- map["width"]
        height <- map["height"]
        videoInfo <- map["video_info"]
        pageUrl <- map["page_url"]
        openBrowser <- map["open_browser"]
        altText <- map["alt_text"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MediaItem()
    }
}

extension MediaItem.VideoInfo: StaticMappable {

    func mapping(map: Map) {
        variants <- map["variants"]
        duration <- map["duration"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MediaItem.VideoInfo()
    }
}

extension MediaItem.VideoInfo.Variant: StaticMappable {

    func mapping(map: Map) {
        url <- map["url"]
        contentType <- map["content_type"]
        bitrate <- map["bitrate"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MediaItem.VideoInfo.Variant()
    }
}


