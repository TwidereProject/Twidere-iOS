// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension UserList: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> UserList {
        var obj = UserList()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


