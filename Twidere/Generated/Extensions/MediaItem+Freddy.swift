// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> MediaItem {
        let url: String = try value.decode(at: "url")
        let mediaUrl: String? = try? value.decode(at: "media_url")
        let previewUrl: String? = try? value.decode(at: "preview_url")
        let type: MediaType = try value.decode(at: "type")
        let width: Int = try value.decode(at: "width")
        let height: Int = try value.decode(at: "height")
        let videoInfo: VideoInfo = try value.decode(at: "video_info")
        let pageUrl: String? = try? value.decode(at: "page_url")
        let openBrowser: Bool = try value.decode(at: "open_browser")
        let altText: String? = try? value.decode(at: "alt_text")
        return MediaItem(url: url, mediaUrl: mediaUrl, previewUrl: previewUrl, type: type, width: width, height: height, videoInfo: videoInfo, pageUrl: pageUrl, openBrowser: openBrowser, altText: altText)
    }

}

extension MediaItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["url"] = self.url.toJSON()
        if (mediaUrl != nil) {
            dict["media_url"] = self.mediaUrl!.toJSON()
        }
        if (previewUrl != nil) {
            dict["preview_url"] = self.previewUrl!.toJSON()
        }
        dict["type"] = self.type.toJSON()
        dict["width"] = self.width.toJSON()
        dict["height"] = self.height.toJSON()
        dict["video_info"] = self.videoInfo.toJSON()
        if (pageUrl != nil) {
            dict["page_url"] = self.pageUrl!.toJSON()
        }
        dict["open_browser"] = self.openBrowser.toJSON()
        if (altText != nil) {
            dict["alt_text"] = self.altText!.toJSON()
        }
        return .dictionary(dict)
    }
}

extension MediaItem.MediaType: JSONDecodable, JSONEncodable {}
    
extension MediaItem.VideoInfo: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> MediaItem.VideoInfo {
        let variants: [Variant] = try value.decodedArray(at: "variants")
        let duration: Int64 = try value.decode(at: "duration")
        return MediaItem.VideoInfo(variants: variants, duration: duration)
    }

}

extension MediaItem.VideoInfo: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["variants"] = self.variants.toJSON()
        dict["duration"] = self.duration.toJSON()
        return .dictionary(dict)
    }
}
extension MediaItem.VideoInfo.Variant: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> MediaItem.VideoInfo.Variant {
        let url: String = try value.decode(at: "url")
        let contentType: String? = try? value.decode(at: "content_type")
        let bitrate: Int64 = try value.decode(at: "bitrate")
        return MediaItem.VideoInfo.Variant(url: url, contentType: contentType, bitrate: bitrate)
    }

}

extension MediaItem.VideoInfo.Variant: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["url"] = self.url.toJSON()
        if (contentType != nil) {
            dict["content_type"] = self.contentType!.toJSON()
        }
        dict["bitrate"] = self.bitrate.toJSON()
        return .dictionary(dict)
    }
}

