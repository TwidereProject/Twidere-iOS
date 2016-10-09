//
//  DatabaseConstants.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/6.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SQLite

let databaseVersion: Int = 3

let accountsTable: Table = Table("accounts")
let homeStatusesTable: Table = Table("home_statuses")
let interactionsTable: Table = Table("interactions")
