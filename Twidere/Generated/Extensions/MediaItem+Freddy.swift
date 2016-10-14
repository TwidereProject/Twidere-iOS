// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MediaItem {
        var obj = MediaItem()
//{initContent}
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
//{initContent}
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
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


