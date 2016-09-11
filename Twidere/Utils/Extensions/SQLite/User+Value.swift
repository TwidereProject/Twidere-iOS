//
//  User+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension User: Value {
    public static var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    public static func fromDatatypeValue(datatypeValue: Blob) -> User {
        return datatypeValue.bytes.withUnsafeBufferPointer { ptr -> User in
            return User.fromByteArray(ptr)
        }
    }
    
    public var datatypeValue: Blob {
        return Blob(bytes: self.toByteArray())
    }
}