//
//  SpanItem+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite

extension Status.Metadata: Value {
    static var declaredDatatype: String {
        return Blob.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: Blob) -> Status.Metadata? {
        return Status.Metadata()
    }
    
    var datatypeValue: Blob {
        return Blob(bytes: [])
    }
}