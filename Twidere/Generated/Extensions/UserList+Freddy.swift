// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension UserList: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> UserList {
        var obj = UserList()
        let accountKey: UserKey = try value.decode(at: "account_key")
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


