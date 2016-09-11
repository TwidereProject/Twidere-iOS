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
    public static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    public static func fromDatatypeValue(datatypeValue: String) -> UserKey {
        return UserKey(rawValue: datatypeValue)
    }
    
    public var datatypeValue: String {
        return self.string
    }
}