//
//  DateExtensions.swift
//  TwidereCore
//
//  Created by Mariotaku Lee on 2017/5/4.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

extension Date {
    
    var millisSince1970: Int64 {
        return Int64(timeIntervalSince1970 * 1000)
    }
    
}
