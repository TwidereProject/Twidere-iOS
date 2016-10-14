// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Account: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Account {
        var obj = Account()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension Account.Config: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Account.Config {
        var obj = Account.Config()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


