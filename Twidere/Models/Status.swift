import SQLite

class Status {

    var _id: Int64!
    var accountKey: UserKey!
    var sortId: Int64!
    var positionKey: Int64!
    var isGap: Bool!
    var createdAt: NSDate!
    var id: String!
    var userKey: UserKey!
    var userName: String!
    var userScreenName: String!
    var userProfileImage: String!
    var textPlain: String!
    var textDisplay: String!
    var metadata: Metadata?
    var quotedId: String?
    var quotedUserKey: UserKey?
    var quotedUserName: String?
    var quotedUserScreenName: String?
    var quotedUserProfileImage: String?
    var quotedTextPlain: String?
    var quotedTextDisplay: String?
    var quotedMetadata: Metadata?
    var retweetedByUserKey: UserKey?
    var retweetedByUserName: String?
    var retweetedByUserScreenName: String?
    var retweetedByUserProfileImage: String?
    var retweetId: String?

    init() {

    }

}