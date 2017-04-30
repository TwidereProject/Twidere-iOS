//
//  SwiftyJSONExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON

extension JSON {
    
    var optionalStringValue: String? {
        switch self.type {
        case .string:
            return self.object as? String
        case .number:
            return self.number?.stringValue
        case .bool:
            return (self.object as? Bool).map { String($0) }
        default:
            return nil
        }
    }
    
}
