//
//  Activity+Value.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import Freddy

extension Activity.ObjectList: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Activity.ObjectList? {
        return try? Activity.ObjectList(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return (try? self.toJSON().serializeString()) ?? ""
    }
}

extension Activity.Action: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Activity.Action? {
        return Activity.Action(rawValue: datatypeValue)
    }
    
    var datatypeValue: String {
        return self.rawValue
    }
}
