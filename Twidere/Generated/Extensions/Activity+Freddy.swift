// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Activity: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Activity {
        var obj = Activity()
        obj._id = -1
        let accountKey: UserKey = try value.decode(at: "account_key")
        let isGap: Bool = try value.decode(at: "is_gap")
        let positionKey: Int64 = try value.decode(at: "position_key")
        let createdAt: Date = try value.decode(at: "created_at")
        let maxSortPosition: Int64 = try value.decode(at: "max_sort_position")
        let minSortPosition: Int64 = try value.decode(at: "min_sort_position")
        let maxPosition: String = try value.decode(at: "max_position")
        let minPosition: String = try value.decode(at: "min_position")
        let action: Action = try value.decode(at: "action")
        let sources: [User] = try value.decodeArray(at: "sources")
        let sourceKeys: [UserKey] = try value.decodeArray(at: "source_keys")
        let targets: ObjectList = try value.decode(at: "targets")
        let targetObjects: ObjectList = try value.decode(at: "target_objects")
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
        let statuses: [Status] = try value.decodeArray(at: "statuses")
        let users: [User] = try value.decodeArray(at: "users")
        let userLists: [UserList] = try value.decodeArray(at: "user_lists")
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


