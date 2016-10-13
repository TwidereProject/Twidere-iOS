//
//  AccountConfig+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import ObjectMapper

extension Account.Config: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Account.Config? {
        return Mapper<Account.Config>().map(JSONString: datatypeValue)
    }
    
    var datatypeValue: String {
        return Mapper().toJSONString(self, prettyPrint: false) ?? ""
    }
}
