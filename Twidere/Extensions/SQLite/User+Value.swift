//
//  User+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Freddy
import SQLite

extension User: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User? {
        return try? User(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return (try? toJSON().serializeString()) ?? ""
    }
}

extension User.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User.Metadata? {
        return try? User.Metadata(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return (try? toJSON().serializeString()) ?? ""
    }
}

struct UserArray: Value {
    let array: [User]
    
    init?(_ array: [User]?) {
        if (array == nil) {
            return nil
        }
        self.array = array!
    }
    
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> UserArray? {
        return UserArray(try? JSON(jsonString: datatypeValue).getArray().map(User.init))
    }
    
    var datatypeValue: String {
        return (try? array.toJSON().serializeString()) ?? ""
    }
}
