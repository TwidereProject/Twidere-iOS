// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension User: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> User {
        var obj = User()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension User.Metadata: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> User.Metadata {
        var obj = User.Metadata()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


