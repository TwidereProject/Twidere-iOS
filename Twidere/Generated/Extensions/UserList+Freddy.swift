// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension UserList: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> UserList {
        let accountKey: UserKey = try value.decode(at: "account_key")
        return UserList(accountKey: accountKey)
    }

}

extension UserList: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

