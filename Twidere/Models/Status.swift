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

    init(row: Row) {
        self._id = row.get(RowIndices._id)
        self.accountKey = row.get(RowIndices.accountKey)
        self.sortId = row.get(RowIndices.sortId)
        self.positionKey = row.get(RowIndices.positionKey)
        self.isGap = row.get(RowIndices.isGap)
        self.createdAt = row.get(RowIndices.createdAt)
        self.id = row.get(RowIndices.id)
        self.userKey = row.get(RowIndices.userKey)
        self.userName = row.get(RowIndices.userName)
        self.userScreenName = row.get(RowIndices.userScreenName)
        self.userProfileImage = row.get(RowIndices.userProfileImage)
        self.textPlain = row.get(RowIndices.textPlain)
        self.textDisplay = row.get(RowIndices.textDisplay)
        self.metadata = row.get(RowIndices.metadata)
        self.quotedId = row.get(RowIndices.quotedId)
        self.quotedUserKey = row.get(RowIndices.quotedUserKey)
        self.quotedUserName = row.get(RowIndices.quotedUserName)
        self.quotedUserScreenName = row.get(RowIndices.quotedUserScreenName)
        self.quotedUserProfileImage = row.get(RowIndices.quotedUserProfileImage)
        self.quotedTextPlain = row.get(RowIndices.quotedTextPlain)
        self.quotedTextDisplay = row.get(RowIndices.quotedTextDisplay)
        self.quotedMetadata = row.get(RowIndices.quotedMetadata)
        self.retweetedByUserKey = row.get(RowIndices.retweetedByUserKey)
        self.retweetedByUserName = row.get(RowIndices.retweetedByUserName)
        self.retweetedByUserScreenName = row.get(RowIndices.retweetedByUserScreenName)
        self.retweetedByUserProfileImage = row.get(RowIndices.retweetedByUserProfileImage)
        self.retweetId = row.get(RowIndices.retweetId)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .Autoincrement)
            t.column(RowIndices.accountKey)
            t.column(RowIndices.sortId)
            t.column(RowIndices.positionKey)
            t.column(RowIndices.isGap)
            t.column(RowIndices.createdAt)
            t.column(RowIndices.id)
            t.column(RowIndices.userKey)
            t.column(RowIndices.userName)
            t.column(RowIndices.userScreenName)
            t.column(RowIndices.userProfileImage)
            t.column(RowIndices.textPlain)
            t.column(RowIndices.textDisplay)
            t.column(RowIndices.metadata)
            t.column(RowIndices.quotedId)
            t.column(RowIndices.quotedUserKey)
            t.column(RowIndices.quotedUserName)
            t.column(RowIndices.quotedUserScreenName)
            t.column(RowIndices.quotedUserProfileImage)
            t.column(RowIndices.quotedTextPlain)
            t.column(RowIndices.quotedTextDisplay)
            t.column(RowIndices.quotedMetadata)
            t.column(RowIndices.retweetedByUserKey)
            t.column(RowIndices.retweetedByUserName)
            t.column(RowIndices.retweetedByUserScreenName)
            t.column(RowIndices.retweetedByUserProfileImage)
            t.column(RowIndices.retweetId)
        }
    }

    static func insertData(table: Table, model: Status) -> Insert {
        return table.insert( [
                RowIndices.accountKey <- model.accountKey,
                RowIndices.sortId <- model.sortId,
                RowIndices.positionKey <- model.positionKey,
                RowIndices.isGap <- model.isGap,
                RowIndices.createdAt <- model.createdAt,
                RowIndices.id <- model.id,
                RowIndices.userKey <- model.userKey,
                RowIndices.userName <- model.userName,
                RowIndices.userScreenName <- model.userScreenName,
                RowIndices.userProfileImage <- model.userProfileImage,
                RowIndices.textPlain <- model.textPlain,
                RowIndices.textDisplay <- model.textDisplay,
                RowIndices.metadata <- model.metadata,
                RowIndices.quotedId <- model.quotedId,
                RowIndices.quotedUserKey <- model.quotedUserKey,
                RowIndices.quotedUserName <- model.quotedUserName,
                RowIndices.quotedUserScreenName <- model.quotedUserScreenName,
                RowIndices.quotedUserProfileImage <- model.quotedUserProfileImage,
                RowIndices.quotedTextPlain <- model.quotedTextPlain,
                RowIndices.quotedTextDisplay <- model.quotedTextDisplay,
                RowIndices.quotedMetadata <- model.quotedMetadata,
                RowIndices.retweetedByUserKey <- model.retweetedByUserKey,
                RowIndices.retweetedByUserName <- model.retweetedByUserName,
                RowIndices.retweetedByUserScreenName <- model.retweetedByUserScreenName,
                RowIndices.retweetedByUserProfileImage <- model.retweetedByUserProfileImage,
                RowIndices.retweetId <- model.retweetId,
        ])
    }

    class RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey?>("account_key")
        static let sortId = Expression<Int64?>("sort_id")
        static let positionKey = Expression<Int64?>("position_key")
        static let isGap = Expression<Bool?>("is_gap")
        static let createdAt = Expression<NSDate?>("created_at")
        static let id = Expression<String?>("status_id")
        static let userKey = Expression<UserKey?>("user_key")
        static let userName = Expression<String?>("user_name")
        static let userScreenName = Expression<String?>("user_screen_name")
        static let userProfileImage = Expression<String?>("user_profile_image")
        static let textPlain = Expression<String?>("text_plain")
        static let textDisplay = Expression<String?>("text_display")
        static let metadata = Expression<Metadata?>("metadata")
        static let quotedId = Expression<String?>("quoted_status_id")
        static let quotedUserKey = Expression<UserKey?>("quoted_user_key")
        static let quotedUserName = Expression<String?>("quoted_user_name")
        static let quotedUserScreenName = Expression<String?>("quoted_user_screen_name")
        static let quotedUserProfileImage = Expression<String?>("quoted_user_profile_image")
        static let quotedTextPlain = Expression<String?>("quoted_text_plain")
        static let quotedTextDisplay = Expression<String?>("quoted_text_display")
        static let quotedMetadata = Expression<Metadata?>("quoted_metadata")
        static let retweetedByUserKey = Expression<UserKey?>("retweeted_by_user_key")
        static let retweetedByUserName = Expression<String?>("retweeted_by_user_name")
        static let retweetedByUserScreenName = Expression<String?>("retweeted_by_user_screen_name")
        static let retweetedByUserProfileImage = Expression<String?>("retweeted_by_user_profile_image")
        static let retweetId = Expression<String?>("retweet_id")

        static let columns: [Expressible] = [
            _id,
            accountKey,
            sortId,
            positionKey,
            isGap,
            createdAt,
            id,
            userKey,
            userName,
            userScreenName,
            userProfileImage,
            textPlain,
            textDisplay,
            metadata,
            quotedId,
            quotedUserKey,
            quotedUserName,
            quotedUserScreenName,
            quotedUserProfileImage,
            quotedTextPlain,
            quotedTextDisplay,
            quotedMetadata,
            retweetedByUserKey,
            retweetedByUserName,
            retweetedByUserScreenName,
            retweetedByUserProfileImage,
            retweetId,
        ]
    }

}