//
//  AccountUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SugarRecord

func defaultAccount() throws -> Account? {
//    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
//    if let defaultAccount = Defaults[.defaultAccount] {
//        return try db.fetch(Request<Account>(predicate: NSPredicate(format: "accountKey == %@", argumentArray: [defaultAccount]))).first ?? allAccounts().first
//    }
    return try allAccounts().first
}

func allAccounts() throws -> [Account] {
    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
    return try db.prepare(accountsTable).map { Account(row: $0) }
}

//func getAccount(key: String) throws -> Account? {
//    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
//    return try db.prepare(accountsTable.filter(Expression<Bool>)).first
//}