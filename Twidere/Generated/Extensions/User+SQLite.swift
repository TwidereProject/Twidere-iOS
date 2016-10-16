
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension User {

    convenience init(row: Row) {
        let _id = row.get(RowIndices._id)
        let accountKey = row.get(RowIndices.accountKey)
        let key = row.get(RowIndices.key)
        let createdAt = row.get(RowIndices.createdAt)
        let isProtected = row.get(RowIndices.isProtected)
        let isVerified = row.get(RowIndices.isVerified)
        let name = row.get(RowIndices.name)
        let screenName = row.get(RowIndices.screenName)
        let profileImageUrl = row.get(RowIndices.profileImageUrl)
        let profileBannerUrl = row.get(RowIndices.profileBannerUrl)
        let profileBackgroundUrl = row.get(RowIndices.profileBackgroundUrl)
        let descriptionPlain = row.get(RowIndices.descriptionPlain)
        let descriptionDisplay = row.get(RowIndices.descriptionDisplay)
        let url = row.get(RowIndices.url)
        let urlExpanded = row.get(RowIndices.urlExpanded)
        let location = row.get(RowIndices.location)
        let metadata = row.get(RowIndices.metadata)
        self.init(_id: _id, accountKey: accountKey, key: key, createdAt: createdAt, isProtected: isProtected, isVerified: isVerified, name: name, screenName: screenName, profileImageUrl: profileImageUrl, profileBannerUrl: profileBannerUrl, profileBackgroundUrl: profileBackgroundUrl, descriptionPlain: descriptionPlain, descriptionDisplay: descriptionDisplay, url: url, urlExpanded: urlExpanded, location: location, metadata: metadata)
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
        static let key = Expression<UserKey>("user_key")
        static let createdAt = Expression<Date?>("created_at")
        static let isProtected = Expression<Bool>("is_protected")
        static let isVerified = Expression<Bool>("is_verified")
        static let name = Expression<String>("name")
        static let screenName = Expression<String>("screen_name")
        static let profileImageUrl = Expression<String?>("profile_image_url")
        static let profileBannerUrl = Expression<String?>("profile_banner_url")
        static let profileBackgroundUrl = Expression<String?>("profile_background_url")
        static let descriptionPlain = Expression<String?>("description_plain")
        static let descriptionDisplay = Expression<String?>("description_display")
        static let url = Expression<String?>("url")
        static let urlExpanded = Expression<String?>("url_expanded")
        static let location = Expression<String?>("location")
        static let metadata = Expression<Metadata?>("metadata")

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
