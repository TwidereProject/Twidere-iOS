//
//  AccountUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SQLite
import TwidereCore

func defaultAccount() throws -> AccountDetails? {
//    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
//    if let defaultAccount = Defaults[.defaultAccount] {
//        return try db.fetch(Request<Account>(predicate: NSPredicate(format: "accountKey == %@", argumentArray: [defaultAccount]))).first ?? allAccounts().first
//    }
    return try allAccounts().first
}

func allAccounts() throws -> [AccountDetails] {
    let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
    return try db.prepare(accountsTable).map { Account(row: $0) }
}

func getAccount(forKey key: UserKey) -> AccountDetails? {
    let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
    let query = accountsTable.filter(Account.RowIndices.key == key).limit(1)
    if let row = try! db.prepare(query).first{ _ in true } {
        return Account(row: row)
    }
    return nil
}
