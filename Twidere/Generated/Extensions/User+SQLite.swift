
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension User {

    init(row: Row) {
        self._id = row.get(RowIndices._id)
        self.accountKey = row.get(RowIndices.accountKey)
        self.key = row.get(RowIndices.key)
        self.createdAt = row.get(RowIndices.createdAt)
        self.isProtected = row.get(RowIndices.isProtected)
        self.isVerified = row.get(RowIndices.isVerified)
        self.name = row.get(RowIndices.name)
        self.screenName = row.get(RowIndices.screenName)
        self.profileImageUrl = row.get(RowIndices.profileImageUrl)
        self.profileBannerUrl = row.get(RowIndices.profileBannerUrl)
        self.profileBackgroundUrl = row.get(RowIndices.profileBackgroundUrl)
        self.descriptionPlain = row.get(RowIndices.descriptionPlain)
        self.descriptionDisplay = row.get(RowIndices.descriptionDisplay)
        self.url = row.get(RowIndices.url)
        self.urlExpanded = row.get(RowIndices.urlExpanded)
        self.location = row.get(RowIndices.location)
        self.metadata = row.get(RowIndices.metadata)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .autoincrement)
            t.column(RowIndices.accountKey)
            t.column(RowIndices.key)
            t.column(RowIndices.createdAt)
            t.column(RowIndices.isProtected)
            t.column(RowIndices.isVerified)
            t.column(RowIndices.name)
            t.column(RowIndices.screenName)
            t.column(RowIndices.profileImageUrl)
            t.column(RowIndices.profileBannerUrl)
            t.column(RowIndices.profileBackgroundUrl)
            t.column(RowIndices.descriptionPlain)
            t.column(RowIndices.descriptionDisplay)
            t.column(RowIndices.url)
            t.column(RowIndices.urlExpanded)
            t.column(RowIndices.location)
            t.column(RowIndices.metadata)
        }
    }

    static func insertData(table: Table, model: User) -> Insert {
        return table.insert( [
                RowIndices.accountKey <- model.accountKey,
                RowIndices.key <- model.key,
                RowIndices.createdAt <- model.createdAt,
                RowIndices.isProtected <- model.isProtected,
                RowIndices.isVerified <- model.isVerified,
                RowIndices.name <- model.name,
                RowIndices.screenName <- model.screenName,
                RowIndices.profileImageUrl <- model.profileImageUrl,
                RowIndices.profileBannerUrl <- model.profileBannerUrl,
                RowIndices.profileBackgroundUrl <- model.profileBackgroundUrl,
                RowIndices.descriptionPlain <- model.descriptionPlain,
                RowIndices.descriptionDisplay <- model.descriptionDisplay,
                RowIndices.url <- model.url,
                RowIndices.urlExpanded <- model.urlExpanded,
                RowIndices.location <- model.location,
                RowIndices.metadata <- model.metadata,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey?>("account_key")
        static let key = Expression<UserKey?>("user_key")
        static let createdAt = Expression<Date?>("created_at")
        static let isProtected = Expression<Bool?>("is_protected")
        static let isVerified = Expression<Bool?>("is_verified")
        static let name = Expression<String?>("name")
        static let screenName = Expression<String?>("screen_name")
        static let profileImageUrl = Expression<String?>("profile_image_url")
        static let profileBannerUrl = Expression<String?>("profile_banner_url")
        static let profileBackgroundUrl = Expression<String?>("profile_background_url")
        static let descriptionPlain = Expression<String?>("description_plain")
        static let descriptionDisplay = Expression<String?>("description_display")
        static let url = Expression<String?>("url")
        static let urlExpanded = Expression<String?>("url_expanded")
        static let location = Expression<String?>("location")
        static let metadata = Expression<User.Metadata?>("metadata")

        static let columns: [Expressible] = [
            _id,
            accountKey,
            key,
            createdAt,
            isProtected,
            isVerified,
            name,
            screenName,
            profileImageUrl,
            profileBannerUrl,
            profileBackgroundUrl,
            descriptionPlain,
            descriptionDisplay,
            url,
            urlExpanded,
            location,
            metadata,
        ]
    }

}
