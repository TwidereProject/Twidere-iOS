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

extension FlatStatus.Metadata: Value {
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(datatypeValue: String) -> FlatStatus.Metadata? {
        guard let json = try! NSJSONSerialization.JSONObjectWithData(datatypeValue.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions(rawValue: 0)) as? JSON else {
            return nil
        }
        return FlatStatus.Metadata(json: json)
    }
    
    var datatypeValue: String {
        guard let json = self.toJSON() else {
            return ""
        }
        return String(data: try! NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions(rawValue: 0)), encoding: NSUTF8StringEncoding)!
    }
}