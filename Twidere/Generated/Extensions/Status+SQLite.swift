
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Status {

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
        self.quotedCreatedAt = row.get(RowIndices.quotedCreatedAt)
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
        self.retweetCreatedAt = row.get(RowIndices.retweetCreatedAt)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .autoincrement)
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
            t.column(RowIndices.quotedCreatedAt)
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
            t.column(RowIndices.retweetCreatedAt)
        }
    }

    static func insertData(table: Table, model: Status) -> Insert {
        var setters: [Setter] = []
        setters.append(RowIndices.accountKey <- model.accountKey)
        setters.append(RowIndices.sortId <- model.sortId)
        setters.append(RowIndices.positionKey <- model.positionKey)
        setters.append(RowIndices.isGap <- model.isGap)
        setters.append(RowIndices.createdAt <- model.createdAt)
        setters.append(RowIndices.id <- model.id)
        setters.append(RowIndices.userKey <- model.userKey)
        setters.append(RowIndices.userName <- model.userName)
        setters.append(RowIndices.userScreenName <- model.userScreenName)
        setters.append(RowIndices.userProfileImage <- model.userProfileImage)
        setters.append(RowIndices.textPlain <- model.textPlain)
        setters.append(RowIndices.textDisplay <- model.textDisplay)
        setters.append(RowIndices.metadata <- model.metadata)
        setters.append(RowIndices.quotedId <- model.quotedId)
        setters.append(RowIndices.quotedCreatedAt <- model.quotedCreatedAt)
        setters.append(RowIndices.quotedUserKey <- model.quotedUserKey)
        setters.append(RowIndices.quotedUserName <- model.quotedUserName)
        setters.append(RowIndices.quotedUserScreenName <- model.quotedUserScreenName)
        setters.append(RowIndices.quotedUserProfileImage <- model.quotedUserProfileImage)
        setters.append(RowIndices.quotedTextPlain <- model.quotedTextPlain)
        setters.append(RowIndices.quotedTextDisplay <- model.quotedTextDisplay)
        setters.append(RowIndices.quotedMetadata <- model.quotedMetadata)
        setters.append(RowIndices.retweetedByUserKey <- model.retweetedByUserKey)
        setters.append(RowIndices.retweetedByUserName <- model.retweetedByUserName)
        setters.append(RowIndices.retweetedByUserScreenName <- model.retweetedByUserScreenName)
        setters.append(RowIndices.retweetedByUserProfileImage <- model.retweetedByUserProfileImage)
        setters.append(RowIndices.retweetId <- model.retweetId)
        setters.append(RowIndices.retweetCreatedAt <- model.retweetCreatedAt)
        return table.insert(setters)
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey>("account_key")
        static let sortId = Expression<Int64>("sort_id")
        static let positionKey = Expression<Int64>("position_key")
        static let isGap = Expression<Bool>("is_gap")
        static let createdAt = Expression<Date>("created_at")
        static let id = Expression<String>("status_id")
        static let userKey = Expression<UserKey>("user_key")
        static let userName = Expression<String>("user_name")
        static let userScreenName = Expression<String>("user_screen_name")
        static let userProfileImage = Expression<String>("user_profile_image")
        static let textPlain = Expression<String>("text_plain")
        static let textDisplay = Expression<String>("text_display")
        static let metadata = Expression<Status.Metadata?>("metadata")
        static let quotedId = Expression<String?>("quoted_status_id")
        static let quotedCreatedAt = Expression<Date?>("quoted_created_at")
        static let quotedUserKey = Expression<UserKey?>("quoted_user_key")
        static let quotedUserName = Expression<String?>("quoted_user_name")
        static let quotedUserScreenName = Expression<String?>("quoted_user_screen_name")
        static let quotedUserProfileImage = Expression<String?>("quoted_user_profile_image")
        static let quotedTextPlain = Expression<String?>("quoted_text_plain")
        static let quotedTextDisplay = Expression<String?>("quoted_text_display")
        static let quotedMetadata = Expression<Status.Metadata?>("quoted_metadata")
        static let retweetedByUserKey = Expression<UserKey?>("retweeted_by_user_key")
        static let retweetedByUserName = Expression<String?>("retweeted_by_user_name")
        static let retweetedByUserScreenName = Expression<String?>("retweeted_by_user_screen_name")
        static let retweetedByUserProfileImage = Expression<String?>("retweeted_by_user_profile_image")
        static let retweetId = Expression<String?>("retweet_id")
        static let retweetCreatedAt = Expression<Date?>("retweet_created_at")

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
            quotedCreatedAt,
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
            retweetCreatedAt,
        ]
    }

}
