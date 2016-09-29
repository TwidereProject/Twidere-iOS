// Automatically generated, DO NOT MODIFY
import Foundation

class Activity {

    // Fields
    var _id: Int64!
    var accountKey: UserKey!
    var positionKey: Int64!
    var createdAt: Date!
    var maxSortPosition: Int64!
    var minSortPosition: Int64!
    var maxPosition: String!
    var minPosition: String!
    var action: String!
    var sources: UserArray!
    var sourceKeys: UserKeyArray!
    var targets: ObjectList!
    var targetObjects: ObjectList!
    // Append body content

    // Sub models
    class ObjectList {
    
        // Fields
        var statuses: [Status]!
        var users: [User]!
        var userLists: [UserList]!
        // Append body content
    
        // Sub models
    
    
    }

}
