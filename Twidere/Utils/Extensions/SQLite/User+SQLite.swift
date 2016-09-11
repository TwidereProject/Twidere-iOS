import SQLite

extension User {

    convenience init(row: Row) {
        self.init()
        self._id = row.get(RowIndices._id)
        self.key = row.get(RowIndices.key)
        self.name = row.get(RowIndices.name)
        self.screenName = row.get(RowIndices.screenName)
        self.profileImageUrl = row.get(RowIndices.profileImageUrl)
        self.profileBannerUrl = row.get(RowIndices.profileBannerUrl)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .Autoincrement)
            t.column(RowIndices.key)
            t.column(RowIndices.name)
            t.column(RowIndices.screenName)
            t.column(RowIndices.profileImageUrl)
            t.column(RowIndices.profileBannerUrl)
        }
    }

    static func insertData(table: Table, model: User) -> Insert {
        return table.insert( [
                RowIndices.key <- model.key,
                RowIndices.name <- model.name,
                RowIndices.screenName <- model.screenName,
                RowIndices.profileImageUrl <- model.profileImageUrl,
                RowIndices.profileBannerUrl <- model.profileBannerUrl,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let key = Expression<UserKey?>("user_key")
        static let name = Expression<String?>("name")
        static let screenName = Expression<String?>("screen_name")
        static let profileImageUrl = Expression<String?>("profile_image_url")
        static let profileBannerUrl = Expression<String?>("profile_banner_url")

        static let columns: [Expressible] = [
            _id,
            key,
            name,
            screenName,
            profileImageUrl,
            profileBannerUrl,
        ]
    }

}