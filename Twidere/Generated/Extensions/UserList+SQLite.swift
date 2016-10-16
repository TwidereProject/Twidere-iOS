
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension UserList {

    convenience init(row: Row) {
        let accountKey = row.get(RowIndices.accountKey)
        self.init(accountKey: accountKey)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices.accountKey)
        }
    }

    static func insertData(table: Table, model: UserList) -> Insert {
        return table.insert( [
                RowIndices.accountKey <- model.accountKey,
        ])
    }

    struct RowIndices {

        static let accountKey = Expression<UserKey>("account_key")

        static let columns: [Expressible] = [
            accountKey,
        ]
    }
}
