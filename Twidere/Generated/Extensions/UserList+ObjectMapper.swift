// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension UserList: StaticMappable {

    func mapping(map: Map) {
        accountKey <- map["account_key"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return UserList()
    }
}


