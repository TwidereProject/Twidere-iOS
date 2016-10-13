// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Activity: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self._id = nil
        self.accountKey = try? value.decode(at: "account_key")
        self.isGap = try? value.decode(at: "is_gap")
        self.positionKey = try? value.decode(at: "position_key")
        self.createdAt = try? value.decode(at: "created_at")
        self.maxSortPosition = try? value.decode(at: "max_sort_position")
        self.minSortPosition = try? value.decode(at: "min_sort_position")
        self.maxPosition = try? value.decode(at: "max_position")
        self.minPosition = try? value.decode(at: "min_position")
        self.action = try? value.decode(at: "action")
        self.sources = try? value.decode(at: "sources")
        self.sourceKeys = try? value.decode(at: "source_keys")
        self.targets = try? value.decode(at: "targets")
        self.targetObjects = try? value.decode(at: "target_objects")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [

        ]
        return .dictionary(dict)
    }
}

extension Activity.ObjectList: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.statuses = try? value.getArray(at: "statuses").map(Status.init)
        self.users = try? value.getArray(at: "users").map(User.init)
        self.userLists = try? value.getArray(at: "user_lists").map(UserList.init)
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [

        ]
        return .dictionary(dict)
    }
}


