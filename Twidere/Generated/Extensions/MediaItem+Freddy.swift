// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.url = try value.decode(at: "url")
        self.mediaUrl = try? value.decode(at: "media_url")
        self.previewUrl = try? value.decode(at: "preview_url")
        self.type = try value.decode(at: "type")
        self.width = try value.decode(at: "width")
        self.height = try value.decode(at: "height")
        self.videoInfo = try value.decode(at: "video_info")
        self.pageUrl = try? value.decode(at: "page_url")
        self.openBrowser = try value.decode(at: "open_browser")
        self.altText = try? value.decode(at: "alt_text")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["url"] = self.url.toJSON()
        dict["type"] = self.type.toJSON()
        dict["width"] = self.width.toJSON()
        dict["height"] = self.height.toJSON()
        dict["video_info"] = self.videoInfo.toJSON()
        dict["open_browser"] = self.openBrowser.toJSON()
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.duration = try value.decode(at: "duration")
        self.variants = try value.getArray(at: "variants").map(Variant.init)
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["duration"] = self.duration.toJSON()
        dict["variants"] = self.variants.toJSON()
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo.Variant: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.url = try value.decode(at: "url")
        self.contentType = try value.decode(at: "content_type")
        self.bitrate = try value.decode(at: "bitrate")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["url"] = self.url.toJSON()
        dict["content_type"] = self.contentType.toJSON()
        dict["bitrate"] = self.bitrate.toJSON()
        return .dictionary(dict)
    }
}


