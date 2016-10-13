// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Status: JSONEncodable, JSONDecodable {

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

extension Status.Metadata: JSONEncodable, JSONDecodable {

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

extension Status.Metadata.InReplyTo: JSONEncodable, JSONDecodable {

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


