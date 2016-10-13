// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension User: JSONEncodable, JSONDecodable {

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

extension User.Metadata: JSONEncodable, JSONDecodable {

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


