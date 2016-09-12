//
//  AccountConfig+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension Account.Config: Value {
    static var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: Blob) -> Account.Config {
        return Account.Config()
    }
    
    var datatypeValue: Blob {
        return Blob(bytes: [])
    }
}