
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Status {

    convenience init(row: Row) {
        let _id = row.get(RowIndices._id)
        let accountKey = row.get(RowIndices.accountKey)
        let sortId = row.get(RowIndices.sortId)
        let positionKey = row.get(RowIndices.positionKey)
        let isGap = row.get(RowIndices.isGap)
        let createdAt = row.get(RowIndices.createdAt)
        let id = row.get(RowIndices.id)
        let userKey = row.get(RowIndices.userKey)
        let userName = row.get(RowIndices.userName)
        let userScreenName = row.get(RowIndices.userScreenName)
        let userProfileImage = row.get(RowIndices.userProfileImage)
        let textPlain = row.get(RowIndices.textPlain)
        let textDisplay = row.get(RowIndices.textDisplay)
        let metadata = row.get(RowIndices.metadata)
        let source = row.get(RowIndices.source)
        let quotedId = row.get(RowIndices.quotedId)
        let quotedCreatedAt = row.get(RowIndices.quotedCreatedAt)
        let quotedUserKey = row.get(RowIndices.quotedUserKey)
        let quotedUserName = row.get(RowIndices.quotedUserName)
        let quotedUserScreenName = row.get(RowIndices.quotedUserScreenName)
        let quotedUserProfileImage = row.get(RowIndices.quotedUserProfileImage)
        let quotedTextPlain = row.get(RowIndices.quotedTextPlain)
        let quotedTextDisplay = row.get(RowIndices.quotedTextDisplay)
        let quotedMetadata = row.get(RowIndices.quotedMetadata)
        let quotedSource = row.get(RowIndices.quotedSource)
        let retweetedByUserKey = row.get(RowIndices.retweetedByUserKey)
        let retweetedByUserName = row.get(RowIndices.retweetedByUserName)
        let retweetedByUserScreenName = row.get(RowIndices.retweetedByUserScreenName)
        let retweetedByUserProfileImage = row.get(RowIndices.retweetedByUserProfileImage)
        let retweetId = row.get(RowIndices.retweetId)
        let retweetCreatedAt = row.get(RowIndices.retweetCreatedAt)
        self.init(_id: _id, accountKey: accountKey, sortId: sortId, positionKey: positionKey, isGap: isGap, createdAt: createdAt, id: id, userKey: userKey, userName: userName, userScreenName: userScreenName, userProfileImage: userProfileImage, textPlain: textPlain, textDisplay: textDisplay, metadata: metadata, source: source, quotedId: quotedId, quotedCreatedAt: quotedCreatedAt, quotedUserKey: quotedUserKey, quotedUserName: quotedUserName, quotedUserScreenName: quotedUserScreenName, quotedUserProfileImage: quotedUserProfileImage, quotedTextPlain: quotedTextPlain, quotedTextDisplay: quotedTextDisplay, quotedMetadata: quotedMetadata, quotedSource: quotedSource, retweetedByUserKey: retweetedByUserKey, retweetedByUserName: retweetedByUserName, retweetedByUserScreenName: retweetedByUserScreenName, retweetedByUserProfileImage: retweetedByUserProfileImage, retweetId: retweetId, retweetCreatedAt: retweetCreatedAt)
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
            t.column(RowIndices.source)
            t.column(RowIndices.quotedId)
            t.column(RowIndices.quotedCreatedAt)
            t.column(RowIndices.quotedUserKey)
            t.column(RowIndices.quotedUserName)
            t.column(RowIndices.quotedUserScreenName)
            t.column(RowIndices.quotedUserProfileImage)
            t.column(RowIndices.quotedTextPlain)
            t.column(RowIndices.quotedTextDisplay)
            t.column(RowIndices.quotedMetadata)
            t.column(RowIndices.quotedSource)
            t.column(RowIndices.retweetedByUserKey)
            t.column(RowIndices.retweetedByUserName)
            t.column(RowIndices.retweetedByUserScreenName)
            t.column(RowIndices.retweetedByUserProfileImage)
            t.column(RowIndices.retweetId)
            t.column(RowIndices.retweetCreatedAt)
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
                RowIndices.source <- model.source,
                RowIndices.quotedId <- model.quotedId,
                RowIndices.quotedCreatedAt <- model.quotedCreatedAt,
                RowIndices.quotedUserKey <- model.quotedUserKey,
                RowIndices.quotedUserName <- model.quotedUserName,
                RowIndices.quotedUserScreenName <- model.quotedUserScreenName,
                RowIndices.quotedUserProfileImage <- model.quotedUserProfileImage,
                RowIndices.quotedTextPlain <- model.quotedTextPlain,
                RowIndices.quotedTextDisplay <- model.quotedTextDisplay,
                RowIndices.quotedMetadata <- model.quotedMetadata,
                RowIndices.quotedSource <- model.quotedSource,
                RowIndices.retweetedByUserKey <- model.retweetedByUserKey,
                RowIndices.retweetedByUserName <- model.retweetedByUserName,
                RowIndices.retweetedByUserScreenName <- model.retweetedByUserScreenName,
                RowIndices.retweetedByUserProfileImage <- model.retweetedByUserProfileImage,
                RowIndices.retweetId <- model.retweetId,
                RowIndices.retweetCreatedAt <- model.retweetCreatedAt,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey?>("account_key")
        static let sortId = Expression<Int64>("sort_id")
        static let positionKey = Expression<Int64>("position_key")
        static let isGap = Expression<Bool>("is_gap")
        static let createdAt = Expression<Date>("created_at")
        static let id = Expression<String>("status_id")
        static let userKey = Expression<UserKey>("user_key")
        static let userName = Expression<String>("user_name")
        static let userScreenName = Expression<String>("user_screen_name")
        static let userProfileImage = Expression<String?>("user_profile_image")
        static let textPlain = Expression<String>("text_plain")
        static let textDisplay = Expression<String>("text_display")
        static let metadata = Expression<Metadata?>("metadata")
        static let source = Expression<String?>("source")
        static let quotedId = Expression<String?>("quoted_status_id")
        static let quotedCreatedAt = Expression<Date?>("quoted_created_at")
        static let quotedUserKey = Expression<UserKey?>("quoted_user_key")
        static let quotedUserName = Expression<String?>("quoted_user_name")
        static let quotedUserScreenName = Expression<String?>("quoted_user_screen_name")
        static let quotedUserProfileImage = Expression<String?>("quoted_user_profile_image")
        static let quotedTextPlain = Expression<String?>("quoted_text_plain")
        static let quotedTextDisplay = Expression<String?>("quoted_text_display")
        static let quotedMetadata = Expression<Metadata?>("quoted_metadata")
        static let quotedSource = Expression<String?>("quoted_source")
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
            source,
            quotedId,
            quotedCreatedAt,
            quotedUserKey,
            quotedUserName,
            quotedUserScreenName,
            quotedUserProfileImage,
            quotedTextPlain,
            quotedTextDisplay,
            quotedMetadata,
            quotedSource,
            retweetedByUserKey,
            retweetedByUserName,
            retweetedByUserScreenName,
            retweetedByUserProfileImage,
            retweetId,
            retweetCreatedAt,
        ]
    }
}
