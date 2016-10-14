//
//  User+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import Freddy

extension User: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User? {
        return try? fromJSON(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return try! self.toJSON().serializeString()
    }
}

extension User: ArrayValue {
    static func arrayFromDatatypeValue(_ datatypeValue: String) -> [User]? {
        guard let json = try? JSON(jsonString: datatypeValue), case let .array(array) = json else {
            return nil
        }
        return try? array.map({ item -> User in
            return try fromJSON(json: item)
        })
    }
    
    static func arrayToDatatypeValue(array: [User]) -> String {
        let json = array.map { user -> JSON in
            return user.toJSON()
        }
        return try! JSON(json).serializeString()
    }
}

extension User.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> User.Metadata? {
        return try? fromJSON(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return try! self.toJSON().serializeString()
    }
}

