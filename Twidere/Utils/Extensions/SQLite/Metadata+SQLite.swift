//
//  SpanItem+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import Gloss

extension Status.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: String) -> Status.Metadata? {
        return datatypeValue.decodeJSON()
    }
    
    var datatypeValue: String {
        return self.encodeJSON()
    }
}