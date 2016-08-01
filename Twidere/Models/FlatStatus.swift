import SQLite

class FlatStatus {

    var _id: Int64!
    var id: String!

    init() {

    }

    init(row: Row) {
        self._id = row.get(RowIndices._id)
        self.id = row.get(RowIndices.id)
    }

    class RowIndices {

        static let _id = Expression<Int64>("_id")
        static let id = Expression<String>("status_id")

        static let columns: [Expressible] = [
            _id,
            id
        ]
    }

}