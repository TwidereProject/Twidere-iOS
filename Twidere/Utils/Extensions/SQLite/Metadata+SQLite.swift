//
//  SpanItem+SQLite.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON

extension FlatStatus.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: String) -> FlatStatus.Metadata {
        let json = JSON.parse(datatypeValue)
        return FlatStatus.Metadata.parse(json)
    }
    
    var datatypeValue: String {
        return self.json.rawString()!
    }
}