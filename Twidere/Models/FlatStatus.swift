import SQLite

class FlatStatus {

    var _id: Int64!
    var accountKey: UserKey!
    var id: String!
    var createdAt: NSDate!
    var userKey: UserKey!
    var userName: String!
    var userScreenName: String!
    var userProfileImage: String!
    var textPlain: String!
    var textDisplay: String!
    var isGap: Bool!
    var metadata: Metadata!
    var quotedId: String!
    var quotedUserKey: UserKey!
    var quotedUserName: String!
    var quotedUserScreenName: String!
    var quotedUserProfileImage: String!
    var quotedTextPlain: String!
    var quotedTextDisplay: String!
    var quotedMetadata: Metadata!

    init() {

    }

    init(row: Row) {
        self._id = row.get(RowIndices._id)
        self.accountKey = row.get(RowIndices.accountKey)
        self.id = row.get(RowIndices.id)
        self.createdAt = row.get(RowIndices.createdAt)
        self.userKey = row.get(RowIndices.userKey)
        self.userName = row.get(RowIndices.userName)
        self.userScreenName = row.get(RowIndices.userScreenName)
        self.userProfileImage = row.get(RowIndices.userProfileImage)
        self.textPlain = row.get(RowIndices.textPlain)
        self.textDisplay = row.get(RowIndices.textDisplay)
        self.isGap = row.get(RowIndices.isGap)
        self.metadata = row.get(RowIndices.metadata)
        self.quotedId = row.get(RowIndices.quotedId)
        self.quotedUserKey = row.get(RowIndices.quotedUserKey)
        self.quotedUserName = row.get(RowIndices.quotedUserName)
        self.quotedUserScreenName = row.get(RowIndices.quotedUserScreenName)
        self.quotedUserProfileImage = row.get(RowIndices.quotedUserProfileImage)
        self.quotedTextPlain = row.get(RowIndices.quotedTextPlain)
        self.quotedTextDisplay = row.get(RowIndices.quotedTextDisplay)
        self.quotedMetadata = row.get(RowIndices.quotedMetadata)
    }

    class RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey>("account_key")
        static let id = Expression<String>("status_id")
        static let createdAt = Expression<NSDate>("created_at")
        static let userKey = Expression<UserKey>("user_key")
        static let userName = Expression<String>("user_name")
        static let userScreenName = Expression<String>("user_screen_name")
        static let userProfileImage = Expression<String>("user_profile_image")
        static let textPlain = Expression<String>("text_plain")
        static let textDisplay = Expression<String>("text_display")
        static let isGap = Expression<Bool>("is_gap")
        static let metadata = Expression<Metadata>("metadata")
        static let quotedId = Expression<String>("quoted_status_id")
        static let quotedUserKey = Expression<UserKey>("quoted_user_key")
        static let quotedUserName = Expression<String>("quoted_user_name")
        static let quotedUserScreenName = Expression<String>("quoted_user_screen_name")
        static let quotedUserProfileImage = Expression<String>("quoted_user_profile_image")
        static let quotedTextPlain = Expression<String>("quoted_text_plain")
        static let quotedTextDisplay = Expression<String>("quoted_text_display")
        static let quotedMetadata = Expression<Metadata>("quoted_metadata")

        static let columns: [Expressible] = [
            _id,
            accountKey,
            id,
            createdAt,
            userKey,
            userName,
            userScreenName,
            userProfileImage,
            textPlain,
            textDisplay,
            isGap,
            metadata,
            quotedId,
            quotedUserKey,
            quotedUserName,
            quotedUserScreenName,
            quotedUserProfileImage,
            quotedTextPlain,
            quotedTextDisplay,
            quotedMetadata
        ]
    }

}