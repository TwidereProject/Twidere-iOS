//
//  SpanItem+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import ObjectMapper

extension Status.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> Status.Metadata? {
        return Mapper<Status.Metadata>().map(JSONString:  datatypeValue)
    }
    
    var datatypeValue: String {
        return Mapper().toJSONString(self, prettyPrint: false) ?? ""
    }
}
