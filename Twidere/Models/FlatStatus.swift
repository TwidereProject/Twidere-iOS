import SQLite

class FlatStatus {

    var _id: Int64!
    var accountKey: UserKey!
    var id: String!
    var createdAt: Int64!
    var userKey: UserKey!
    var userName: String!
    var userScreenName: String!
    var userProfileImage: String!

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
    }

    class RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey>("account_key")
        static let id = Expression<String>("status_id")
        static let createdAt = Expression<Int64>("created_at")
        static let userKey = Expression<UserKey>("user_key")
        static let userName = Expression<String>("user_name")
        static let userScreenName = Expression<String>("user_screen_name")
        static let userProfileImage = Expression<String>("user_profile_image")

        static let columns: [Expressible] = [
            _id,
            accountKey,
            id,
            createdAt,
            userKey,
            userName,
            userScreenName,
            userProfileImage
        ]
    }

}