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
    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStorage
    if let defaultAccount = Defaults[.defaultAccount] {
        return try db.fetch(Request<Account>(predicate: NSPredicate(format: "attributeName == %@", argumentArray: [defaultAccount]))).first ?? allAccounts().first
    }
    return try allAccounts().first
}

func allAccounts() throws -> [Account] {
    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStorage
    return try db.fetch(Request<Account>())
}