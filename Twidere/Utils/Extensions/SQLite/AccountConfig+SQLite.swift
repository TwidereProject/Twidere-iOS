//
//  AccountConfig+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension AccountConfig: Value {
    public static var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    public static func fromDatatypeValue(datatypeValue: Blob) -> AccountConfig {
        return datatypeValue.bytes.withUnsafeBufferPointer { ptr -> AccountConfig in
            return AccountConfig.fromByteArray(ptr)
        }
    }
    
    public var datatypeValue: Blob {
        return Blob(bytes: self.toByteArray())
    }
}