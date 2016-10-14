// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Status: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Status {
        var obj = Status()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension Status.Metadata: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Status.Metadata {
        var obj = Status.Metadata()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension Status.Metadata.InReplyTo: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Status.Metadata.InReplyTo {
        var obj = Status.Metadata.InReplyTo()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


