// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension UserList: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.accountKey = try? value.decode(at: "account_key")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [

        ]
        return .dictionary(dict)
    }
}


