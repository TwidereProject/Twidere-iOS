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
        self.init(timeIntervalSince1970: Double(timeIntervalSince1970Millis) / 1000.0)
    }
    
    var timeIntervalSince1970Millis: Int64 {
        get {
            return Int64(self.timeIntervalSince1970 * 1000)
        }
    }
    
}

extension Date {
    struct Formatter {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
    }
    var iso8601String: String {
        return Formatter.iso8601.string(from: self)
    }
    
    init?(iso8601String: String) {
        guard let parsed = Date.Formatter.iso8601.date(from: iso8601String) else {
            return nil
        }
        self = parsed
    }
}
