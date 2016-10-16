// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONDecodable {

    init(json value: JSON) throws {
        self.url = try value.decode(at: "url")
        self.mediaUrl = try value.decode(at: "media_url")
        self.previewUrl = try value.decode(at: "preview_url")
        self.type = try value.decode(at: "type")
        self.width = try value.decode(at: "width")
        self.height = try value.decode(at: "height")
        self.videoInfo = try value.decode(at: "video_info")
        self.pageUrl = try value.decode(at: "page_url")
        self.openBrowser = try value.decode(at: "open_browser")
        self.altText = try value.decode(at: "alt_text")
    }

}

extension MediaItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MediaItem.MediaType: JSONDecodable, JSONEncodable {}
    
extension MediaItem.VideoInfo: JSONDecodable {

    init(json value: JSON) throws {
        self.variants = try value.decodedArray(at: "variants")
        self.duration = try value.decode(at: "duration")
    }

}

extension MediaItem.VideoInfo: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}
extension MediaItem.VideoInfo.Variant: JSONDecodable {

    init(json value: JSON) throws {
        self.url = try value.decode(at: "url")
        self.contentType = try value.decode(at: "content_type")
        self.bitrate = try value.decode(at: "bitrate")
    }

}

extension MediaItem.VideoInfo.Variant: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

