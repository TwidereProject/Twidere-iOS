// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension Activity: StaticMappable {

    func mapping(map: Map) {
        accountKey <- (map["account_key"], UserKeyTransform())
        isGap <- map["is_gap"]
        positionKey <- map["position_key"]
        createdAt <- map["created_at"]
        maxSortPosition <- map["max_sort_position"]
        minSortPosition <- map["min_sort_position"]
        maxPosition <- map["max_position"]
        minPosition <- map["min_position"]
        action <- map["action"]
        sources <- map["sources"]
        sourceKeys <- map["source_keys"]
        targets <- map["targets"]
        targetObjects <- map["target_objects"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Activity()
    }
}

extension Activity.ObjectList: StaticMappable {

    func mapping(map: Map) {
        statuses <- map["statuses"]
        users <- map["users"]
        userLists <- map["user_lists"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Activity.ObjectList()
    }
}


