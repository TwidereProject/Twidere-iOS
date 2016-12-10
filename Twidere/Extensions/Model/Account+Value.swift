//
//  AccountConfig+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import Freddy

extension Account.Credentials: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Account.Credentials? {
        return try? Account.Credentials.fromJSON(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return try! self.toJSON().serializeString()
    }
}

extension Account.Extras: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Account.Extras? {
        return try? Account.Extras.fromJSON(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return try! self.toJSON().serializeString()
    }
}
