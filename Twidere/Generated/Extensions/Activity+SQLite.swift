
// Automatically generated, DO NOT MODIFY
import Foundation
import SQLite

extension Activity {

    convenience init(row: Row) {
        self.init()
        self._id = row.get(RowIndices._id)
        self.accountKey = row.get(RowIndices.accountKey)
        self.isGap = row.get(RowIndices.isGap)
        self.positionKey = row.get(RowIndices.positionKey)
        self.createdAt = row.get(RowIndices.createdAt)
        self.maxSortPosition = row.get(RowIndices.maxSortPosition)
        self.minSortPosition = row.get(RowIndices.minSortPosition)
        self.maxPosition = row.get(RowIndices.maxPosition)
        self.minPosition = row.get(RowIndices.minPosition)
        self.action = row.get(RowIndices.action)
        self.sources = row.get(RowIndices.sources)
        self.sourceKeys = row.get(RowIndices.sourceKeys)
        self.targets = row.get(RowIndices.targets)
        self.targetObjects = row.get(RowIndices.targetObjects)
    }

    static func createTable(table: Table, temporary: Bool = false, ifNotExists: Bool = false) -> String {
        return table.create(temporary: temporary, ifNotExists: ifNotExists) { t in
            t.column(RowIndices._id, primaryKey: .autoincrement)
            t.column(RowIndices.accountKey)
            t.column(RowIndices.isGap)
            t.column(RowIndices.positionKey)
            t.column(RowIndices.createdAt)
            t.column(RowIndices.maxSortPosition)
            t.column(RowIndices.minSortPosition)
            t.column(RowIndices.maxPosition)
            t.column(RowIndices.minPosition)
            t.column(RowIndices.action)
            t.column(RowIndices.sources)
            t.column(RowIndices.sourceKeys)
            t.column(RowIndices.targets)
            t.column(RowIndices.targetObjects)
        }
    }

    static func insertData(table: Table, model: Activity) -> Insert {
        return table.insert( [
                RowIndices.accountKey <- model.accountKey,
                RowIndices.isGap <- model.isGap,
                RowIndices.positionKey <- model.positionKey,
                RowIndices.createdAt <- model.createdAt,
                RowIndices.maxSortPosition <- model.maxSortPosition,
                RowIndices.minSortPosition <- model.minSortPosition,
                RowIndices.maxPosition <- model.maxPosition,
                RowIndices.minPosition <- model.minPosition,
                RowIndices.action <- model.action,
                RowIndices.sources <- model.sources,
                RowIndices.sourceKeys <- model.sourceKeys,
                RowIndices.targets <- model.targets,
                RowIndices.targetObjects <- model.targetObjects,
        ])
    }

    struct RowIndices {

        static let _id = Expression<Int64>("_id")
        static let accountKey = Expression<UserKey?>("account_key")
        static let isGap = Expression<Bool>("is_gap")
        static let positionKey = Expression<Int64>("position_key")
        static let createdAt = Expression<Date>("created_at")
        static let maxSortPosition = Expression<Int64>("max_sort_position")
        static let minSortPosition = Expression<Int64>("min_sort_position")
        static let maxPosition = Expression<String>("max_position")
        static let minPosition = Expression<String>("min_position")
        static let action = Expression<Action>("action")
        static let sources = Expression<[User]>("sources")
        static let sourceKeys = Expression<[UserKey]>("source_keys")
        static let targets = Expression<ObjectList?>("targets")
        static let targetObjects = Expression<ObjectList?>("target_objects")

        static let columns: [Expressible] = [
            _id,
            accountKey,
            isGap,
            positionKey,
            createdAt,
            maxSortPosition,
            minSortPosition,
            maxPosition,
            minPosition,
            action,
            sources,
            sourceKeys,
            targets,
            targetObjects,
        ]
    }

}
