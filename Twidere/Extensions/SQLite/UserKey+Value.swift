//
//  UserKey+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/22.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension UserKey: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> UserKey {
        return UserKey(rawValue: datatypeValue)
    }
    
    var datatypeValue: String {
        return self.string
    }
}
