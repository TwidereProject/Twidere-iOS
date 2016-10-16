
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Account {

    convenience init(row: Row) {
        let _id = row.get(RowIndices._id)
        let key = row.get(RowIndices.key)
        let type = row.get(RowIndices.type)
        let apiUrlFormat = row.get(RowIndices.apiUrlFormat)
        let authType = row.get(RowIndices.authType)
        let basicPassword = row.get(RowIndices.basicPassword)
        let basicUsername = row.get(RowIndices.basicUsername)
        let consumerKey = row.get(RowIndices.consumerKey)
        let consumerSecret = row.get(RowIndices.consumerSecret)
        let noVersionSuffix = row.get(RowIndices.noVersionSuffix)
        let oauthToken = row.get(RowIndices.oauthToken)
        let oauthTokenSecret = row.get(RowIndices.oauthTokenSecret)
        let sameOAuthSigningUrl = row.get(RowIndices.sameOAuthSigningUrl)
        let config = row.get(RowIndices.config)
        let user = row.get(RowIndices.user)
        self.init(_id: _id, key: key, type: type, apiUrlFormat: apiUrlFormat, authType: authType, basicPassword: basicPassword, basicUsername: basicUsername, consumerKey: consumerKey, consumerSecret: consumerSecret, noVersionSuffix: noVersionSuffix, oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret, sameOAuthSigningUrl: sameOAuthSigningUrl, config: config, user: user)
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
        return table.insert( [
                RowIndices.key <- model.key,
                RowIndices.type <- model.type,
                RowIndices.apiUrlFormat <- model.apiUrlFormat,
                RowIndices.authType <- model.authType,
                RowIndices.basicPassword <- model.basicPassword,
                RowIndices.basicUsername <- model.basicUsername,
                RowIndices.consumerKey <- model.consumerKey,
                RowIndices.consumerSecret <- model.consumerSecret,
                RowIndices.noVersionSuffix <- model.noVersionSuffix,
                RowIndices.oauthToken <- model.oauthToken,
                RowIndices.oauthTokenSecret <- model.oauthTokenSecret,
                RowIndices.sameOAuthSigningUrl <- model.sameOAuthSigningUrl,
                RowIndices.config <- model.config,
                RowIndices.user <- model.user,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let key = Expression<UserKey>("account_key")
        static let type = Expression<AccountType>("account_type")
        static let apiUrlFormat = Expression<String>("api_url_format")
        static let authType = Expression<AuthType>("auth_type")
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
extension Account.AccountType: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }

    static func fromDatatypeValue(_ datatypeValue: String) -> Account.AccountType? {
        return Account.AccountType(rawValue: datatypeValue)
    }

    var datatypeValue: String {
        return self.rawValue
    }
}
extension Account.AuthType: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }

    static func fromDatatypeValue(_ datatypeValue: String) -> Account.AuthType? {
        return Account.AuthType(rawValue: datatypeValue)
    }

    var datatypeValue: String {
        return self.rawValue
    }
}
