//
//  DatabaseMigration.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SQLite

class DatabaseMigration {
    
    func create(_ db: Connection) throws {
        try db.transaction {
            _ = try db.run(Account.createTable(table: accountsTable))
            _ = try db.run(Status.createTable(table: homeStatusesTable))
        }
    }
    
    func upgrade(_ db: Connection, oldVersion: Int, newVersion: Int) throws {
        var curVersion = oldVersion
        while (curVersion < newVersion) {
            let nextVersion = curVersion + 1
            if (try upgrade(db, from: curVersion, to: nextVersion)) {
                curVersion = nextVersion
            } else {
                fatalError("\(curVersion) -> \(nextVersion) not handled")
            }
        }
    }
    
    func upgrade(_ db: Connection, from: Int, to: Int) throws -> Bool {
        switch to {
        case 1:
            return true
        case 2:
            _ = try db.run(Activity.createTable(table: interactionsTable))
            return true
        case 3:
            _ = try db.run(homeStatusesTable.delete())
            _ = try db.run(homeStatusesTable.addColumn(Status.RowIndices.quotedCreatedAt))
            _ = try db.run(homeStatusesTable.addColumn(Status.RowIndices.retweetCreatedAt))
            return true
        default:
            return false
        }
    }
}
