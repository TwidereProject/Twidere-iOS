
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Account {

    convenience init(row: Row) {
        let _id = row.get(RowIndices._id)
        let key = row.get(RowIndices.key)
        let type = row.get(RowIndices.type)
        let authType = row.get(RowIndices.authType)
        let credentials = row.get(RowIndices.credentials)
        let user = row.get(RowIndices.user)
        let extras = row.get(RowIndices.extras)
        self.init(_id: _id, key: key, type: type, authType: authType, credentials: credentials, user: user, extras: extras)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .autoincrement)
            t.column(RowIndices.key)
            t.column(RowIndices.type)
            t.column(RowIndices.authType)
            t.column(RowIndices.credentials)
            t.column(RowIndices.user)
            t.column(RowIndices.extras)
        }
    }

    static func insertData(table: Table, model: Account) -> Insert {
        return table.insert( [
                RowIndices.key <- model.key,
                RowIndices.type <- model.type,
                RowIndices.authType <- model.authType,
                RowIndices.credentials <- model.credentials,
                RowIndices.user <- model.user,
                RowIndices.extras <- model.extras,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let key = Expression<UserKey>("account_key")
        static let type = Expression<AccountType>("account_type")
        static let authType = Expression<AuthType>("auth_type")
        static let credentials = Expression<Credentials>("credentials")
        static let user = Expression<User>("user")
        static let extras = Expression<Extras?>("extras")

        static let columns: [Expressible] = [
            _id,
            key,
            type,
            authType,
            credentials,
            user,
            extras,
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
