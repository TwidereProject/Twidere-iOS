//
//  NSDateExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/22.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension NSDate {
    
    var timeIntervalSince1970Millis: Int64 {
        get {
            return Int64(self.timeIntervalSince1970 * 1000)
        }
    }
    
}