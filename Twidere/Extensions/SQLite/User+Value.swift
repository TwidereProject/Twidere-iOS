//
//  User+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import ObjectMapper

extension User: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User? {
        return Mapper<User>().map(JSONString: datatypeValue)
    }
    
    var datatypeValue: String {
        return Mapper().toJSONString(self, prettyPrint: false) ?? ""
    }
}

extension User.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User.Metadata? {
        return Mapper<User.Metadata>().map(JSONString: datatypeValue)
    }
    
    var datatypeValue: String {
        return Mapper().toJSONString(self, prettyPrint: false) ?? ""
    }
}

struct UserArray: Value {
    let array: [User]
    
    init(_ array: [User]) {
        self.array = array
    }
    
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> UserArray {
        return UserArray(Mapper<User>().mapArray(JSONString: datatypeValue) ?? [])
    }
    
    var datatypeValue: String {
        return Mapper().toJSONString(self.array, prettyPrint: false) ?? ""
    }
}
