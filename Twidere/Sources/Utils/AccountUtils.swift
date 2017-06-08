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
    return nil
}

func allAccounts() throws -> [AccountDetails] {
    return [AccountDetails]()
}

func getAccount(forKey key: UserKey) -> AccountDetails? {
    return nil
}
