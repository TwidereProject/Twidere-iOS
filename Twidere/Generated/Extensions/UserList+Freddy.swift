// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension UserList: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> UserList {
        var obj = UserList()
        let accountKey: UserKey = try value.decode(at: "account_key")
        return obj
    }

}

extension UserList: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

