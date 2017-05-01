//
//  Date+MicroBlog.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PMJackson

private let twitterDateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    return f
}()

extension Date {
    
    static func parseTwitterDate(_ parser: PMJacksonParser) -> Date! {
        return parseTwitterDate(parser.getValueAsString())
    }
    
    static func parseTwitterDate(_ string: String?) -> Date! {
        return parseTwitterDate(string)
    }
    
}
