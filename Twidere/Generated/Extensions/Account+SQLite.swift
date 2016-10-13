
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Account {

    init(row: Row) {
        self._id = row.get(RowIndices._id)
        self.key = row.get(RowIndices.key)
        self.type = row.get(RowIndices.type)
        self.apiUrlFormat = row.get(RowIndices.apiUrlFormat)
        self.authType = row.get(RowIndices.authType)
        self.basicPassword = row.get(RowIndices.basicPassword)
        self.basicUsername = row.get(RowIndices.basicUsername)
        self.consumerKey = row.get(RowIndices.consumerKey)
        self.consumerSecret = row.get(RowIndices.consumerSecret)
        self.noVersionSuffix = row.get(RowIndices.noVersionSuffix)
        self.oauthToken = row.get(RowIndices.oauthToken)
        self.oauthTokenSecret = row.get(RowIndices.oauthTokenSecret)
        self.sameOAuthSigningUrl = row.get(RowIndices.sameOAuthSigningUrl)
        self.config = row.get(RowIndices.config)
        self.user = row.get(RowIndices.user)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .autoincrement)
            t.column(RowIndices.key)
            t.column(RowIndices.type)
            t.column(RowIndices.apiUrlFormat)
            t.column(RowIndices.authType)
            t.column(RowIndices.basicPassword)
            t.column(RowIndices.basicUsername)
            t.column(RowIndices.consumerKey)
            t.column(RowIndices.consumerSecret)
            t.column(RowIndices.noVersionSuffix)
            t.column(RowIndices.oauthToken)
            t.column(RowIndices.oauthTokenSecret)
            t.column(RowIndices.sameOAuthSigningUrl)
            t.column(RowIndices.config)
            t.column(RowIndices.user)
        }
    }

    static func insertData(table: Table, model: Account) -> Insert {
        var setters: [Setter] = []
        setters.append(RowIndices.key <- model.key)
        setters.append(RowIndices.type <- model.type)
        setters.append(RowIndices.apiUrlFormat <- model.apiUrlFormat)
        setters.append(RowIndices.authType <- model.authType)
        setters.append(RowIndices.basicPassword <- model.basicPassword)
        setters.append(RowIndices.basicUsername <- model.basicUsername)
        setters.append(RowIndices.consumerKey <- model.consumerKey)
        setters.append(RowIndices.consumerSecret <- model.consumerSecret)
        setters.append(RowIndices.noVersionSuffix <- model.noVersionSuffix)
        setters.append(RowIndices.oauthToken <- model.oauthToken)
        setters.append(RowIndices.oauthTokenSecret <- model.oauthTokenSecret)
        setters.append(RowIndices.sameOAuthSigningUrl <- model.sameOAuthSigningUrl)
        setters.append(RowIndices.config <- model.config)
        setters.append(RowIndices.user <- model.user)
        return table.insert(setters)
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let key = Expression<UserKey>("account_key")
        static let type = Expression<AccountType>("account_type")
        static let apiUrlFormat = Expression<String>("api_url_format")
        static let authType = Expression<String>("auth_type")
        static let basicPassword = Expression<String?>("basic_password")
        static let basicUsername = Expression<String?>("basic_username")
        static let consumerKey = Expression<String?>("consumer_key")
        static let consumerSecret = Expression<String?>("consumer_secret")
        static let noVersionSuffix = Expression<Bool>("no_version_suffix")
        static let oauthToken = Expression<String?>("oauth_token")
        static let oauthTokenSecret = Expression<String?>("oauth_token_secret")
        static let sameOAuthSigningUrl = Expression<Bool>("same_oauth_signing_url")
        static let config = Expression<Config?>("config")
        static let user = Expression<User>("user")

        static let columns: [Expressible] = [
            _id,
            key,
            type,
            apiUrlFormat,
            authType,
            basicPassword,
            basicUsername,
            consumerKey,
            consumerSecret,
            noVersionSuffix,
            oauthToken,
            oauthTokenSecret,
            sameOAuthSigningUrl,
            config,
            user,
        ]
    }

}
