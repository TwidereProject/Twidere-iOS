// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Activity: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Activity {
        var obj = Activity()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension Activity.ObjectList: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Activity.ObjectList {
        var obj = Activity.ObjectList()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


