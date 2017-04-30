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
        var dict: [String: JSON] = [:]
        dict["account_key"] = self.accountKey.toJSON()
        return .dictionary(dict)
    }
}

