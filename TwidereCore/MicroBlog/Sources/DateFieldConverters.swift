//
//  TwitterDateFieldConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson

struct TwitterDateFieldConverter: JsonFieldConverter {
    typealias T = Date
    
    private static let twitterDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        return f
    }()
    
    static func parse(_ parser: PMJacksonParser) -> Date! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return twitterDateFormatter.date(from: str)
    }
    
    
}
