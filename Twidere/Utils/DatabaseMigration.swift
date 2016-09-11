//
//  DatabaseMigration.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SQLite

class DatabaseMigration {
    
    func create(db: Connection) throws {
        try db.transaction {
            try db.run(Status.createTable(homeStatusesTable))
        }
    }
    
    func upgrade(db: Connection, oldVersion: Int, newVersion: Int) throws {
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
    
    func upgrade(db: Connection, from: Int, to: Int) throws -> Bool {
        switch to {
        case 1:
            return true
        case 2:
            try db.transaction {
                try db.run(homeStatusesTable.delete())
                try db.run(homeStatusesTable.addColumn(Status.RowIndices.sortId))
                try db.run(homeStatusesTable.addColumn(Status.RowIndices.positionKey))
            }
            return true
        default:
            return false
        }
    }
}