//
//  SpanItem+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import Freddy

extension Status.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Status.Metadata? {
        return try? Status.Metadata(json: JSON(jsonString: datatypeValue))
    }
    
    var datatypeValue: String {
        return (try? toJSON().serializeString()) ?? ""
    }
}
