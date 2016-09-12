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
        return Blob.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: Blob) -> User {
        return User()
    }
    
    var datatypeValue: Blob {
        return Blob(bytes: [])
    }
}

extension User.Metadata: Value {
    static var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: Blob) -> User.Metadata {
        return User.Metadata()
    }
    
    var datatypeValue: Blob {
        return Blob(bytes: [])
    }
}