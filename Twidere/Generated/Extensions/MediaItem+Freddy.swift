// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MediaItem {
        var obj = MediaItem()
        let url: String = try value.decode(at: "url")
        let mediaUrl: String = try value.decode(at: "media_url")
        let previewUrl: String = try value.decode(at: "preview_url")
        let type: MediaType = try value.decode(at: "type")
        let width: Int = try value.decode(at: "width")
        let height: Int = try value.decode(at: "height")
        let videoInfo: VideoInfo = try value.decode(at: "video_info")
        let pageUrl: String = try value.decode(at: "page_url")
        let openBrowser: Bool = try value.decode(at: "open_browser")
        let altText: String = try value.decode(at: "alt_text")
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MediaItem.VideoInfo {
        var obj = MediaItem.VideoInfo()
        let variants: [Variant] = try value.decodeArray(at: "variants")
        let duration: Int64 = try value.decode(at: "duration")
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo.Variant: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MediaItem.VideoInfo.Variant {
        var obj = MediaItem.VideoInfo.Variant()
        let url: String = try value.decode(at: "url")
        let contentType: String = try value.decode(at: "content_type")
        let bitrate: Int64 = try value.decode(at: "bitrate")
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


