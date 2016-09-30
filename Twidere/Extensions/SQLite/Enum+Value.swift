//
//  Enum+Value.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension Activity.Action: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Activity.Action? {
        return Activity.Action(rawValue: datatypeValue.lowercasingFirstLetter())
    }
    
    var datatypeValue: String {
        return self.rawValue
    }
}
