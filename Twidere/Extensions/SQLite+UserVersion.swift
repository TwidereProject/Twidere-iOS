//
//  SQLite+UserVersion.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SQLite

extension Connection {

    public var userVersion: Int {
        get { return Int(scalar("PRAGMA user_version") as! Int64) }
        set { try! run("PRAGMA user_version = \(newValue)") }
    }
    
}