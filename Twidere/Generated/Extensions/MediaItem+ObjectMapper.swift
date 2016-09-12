// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension MediaItem: StaticMappable {

    func mapping(map: Map) {
        url <- map["url"]
        mediaUrl <- map["mediaUrl"]
        previewUrl <- map["previewUrl"]
        type <- map["type"]
        width <- map["width"]
        height <- map["height"]
        videoInfo <- map["videoInfo"]
        pageUrl <- map["pageUrl"]
        openBrowser <- map["openBrowser"]
        altText <- map["altText"]
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
        contentType <- map["contentType"]
        bitrate <- map["bitrate"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MediaItem.VideoInfo.Variant()
    }
}


