// Automatically generated, DO NOT MODIFY
import Foundation
    
class Activity {

    // Fields
    var _id: Int64 = -1
    var accountKey: UserKey!
    var isGap: Bool = false
    var positionKey: Int64 = -1
    var createdAt: Date
    var maxSortPosition: Int64
    var minSortPosition: Int64
    var maxPosition: String
    var minPosition: String
    var action: Action
    var sources: [User]
    var sourceKeys: [UserKey]
    var targets: ObjectList!
    var targetObjects: ObjectList!
    // Initializers
    init(_id: Int64 = -1, accountKey: UserKey! = nil, isGap: Bool = false, positionKey: Int64 = -1, createdAt: Date, maxSortPosition: Int64, minSortPosition: Int64, maxPosition: String, minPosition: String, action: Action, sources: [User], sourceKeys: [UserKey], targets: ObjectList! = nil, targetObjects: ObjectList! = nil) {
        self._id = _id
        self.accountKey = accountKey
        self.isGap = isGap
        self.positionKey = positionKey
        self.createdAt = createdAt
        self.maxSortPosition = maxSortPosition
        self.minSortPosition = minSortPosition
        self.maxPosition = maxPosition
        self.minPosition = minPosition
        self.action = action
        self.sources = sources
        self.sourceKeys = sourceKeys
        self.targets = targets
        self.targetObjects = targetObjects
    }
    // Append body content

    // Sub models
    enum Action : String {
    
        // Fields
        case favorite
        case follow
        case mention
        case reply
        case retweet
        case listMemberAdded
        case listCreated
        case favoritedRetweet
        case retweetedRetweet
        case quote
        case retweetedMention
        case favoritedMention
        case joinedTwitter
        case mediaTagged
        case favoritedMediaTagged
        case retweetedMediaTagged
        // Append body content
    
    
    }
    class ObjectList {
    
        // Fields
        var statuses: [Status]? = nil
        var users: [User]? = nil
        var userLists: [UserList]? = nil
        // Initializers
        init(statuses: [Status]? = nil, users: [User]? = nil, userLists: [UserList]? = nil) {
            self.statuses = statuses
            self.users = users
            self.userLists = userLists
        }
        // Append body content
    
        // Sub models
    
    }
}
