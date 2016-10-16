// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Activity: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Activity {
        let accountKey: UserKey? = try? value.decode(at: "account_key")
        let isGap: Bool = try value.decode(at: "is_gap")
        let positionKey: Int64 = try value.decode(at: "position_key")
        let createdAt: Date = try value.decode(at: "created_at")
        let maxSortPosition: Int64 = try value.decode(at: "max_sort_position")
        let minSortPosition: Int64 = try value.decode(at: "min_sort_position")
        let maxPosition: String = try value.decode(at: "max_position")
        let minPosition: String = try value.decode(at: "min_position")
        let action: Action = try value.decode(at: "action")
        let sources: [User] = try value.decodedArray(at: "sources")
        let sourceKeys: [UserKey] = try value.decodedArray(at: "source_keys")
        let targets: ObjectList? = try? value.decode(at: "targets")
        let targetObjects: ObjectList? = try? value.decode(at: "target_objects")
        return Activity(accountKey: accountKey, isGap: isGap, positionKey: positionKey, createdAt: createdAt, maxSortPosition: maxSortPosition, minSortPosition: minSortPosition, maxPosition: maxPosition, minPosition: minPosition, action: action, sources: sources, sourceKeys: sourceKeys, targets: targets, targetObjects: targetObjects)
    }

}

extension Activity: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        if (accountKey != nil) {
            dict["account_key"] = self.accountKey!.toJSON()
        }
        dict["is_gap"] = self.isGap.toJSON()
        dict["position_key"] = self.positionKey.toJSON()
        dict["created_at"] = self.createdAt.toJSON()
        dict["max_sort_position"] = self.maxSortPosition.toJSON()
        dict["min_sort_position"] = self.minSortPosition.toJSON()
        dict["max_position"] = self.maxPosition.toJSON()
        dict["min_position"] = self.minPosition.toJSON()
        dict["action"] = self.action.toJSON()
        dict["sources"] = self.sources.toJSON()
        dict["source_keys"] = self.sourceKeys.toJSON()
        if (targets != nil) {
            dict["targets"] = self.targets!.toJSON()
        }
        if (targetObjects != nil) {
            dict["target_objects"] = self.targetObjects!.toJSON()
        }
        return .dictionary(dict)
    }
}

extension Activity.Action: JSONDecodable, JSONEncodable {}
    
extension Activity.ObjectList: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Activity.ObjectList {
        let statuses: [Status]? = try? value.decodedArray(at: "statuses")
        let users: [User]? = try? value.decodedArray(at: "users")
        let userLists: [UserList]? = try? value.decodedArray(at: "user_lists")
        return Activity.ObjectList(statuses: statuses, users: users, userLists: userLists)
    }

}

extension Activity.ObjectList: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        if (statuses != nil) {
            dict["statuses"] = self.statuses!.toJSON()
        }
        if (users != nil) {
            dict["users"] = self.users!.toJSON()
        }
        if (userLists != nil) {
            dict["user_lists"] = self.userLists!.toJSON()
        }
        return .dictionary(dict)
    }
}

