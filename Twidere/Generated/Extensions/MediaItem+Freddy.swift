// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension MediaItem: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
//{initContent}
        throw JSON.Error.stringSerializationError
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
//{initContent}
        throw JSON.Error.stringSerializationError
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MediaItem.VideoInfo.Variant: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
//{initContent}
        throw JSON.Error.stringSerializationError
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


