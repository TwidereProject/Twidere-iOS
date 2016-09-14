//
//  NSDateExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/22.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Date {
    
    init(timeIntervalSince1970Millis: Int64) {
        (self as NSDate).init(timeIntervalSince1970: Double(timeIntervalSince1970Millis) / 1000.0)
    }
    
    var timeIntervalSince1970Millis: Int64 {
        get {
            return Int64(self.timeIntervalSince1970 * 1000)
        }
    }
    
}
