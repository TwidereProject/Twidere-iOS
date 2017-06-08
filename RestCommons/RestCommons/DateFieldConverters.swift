//
//  TwitterDateFieldConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson

public struct JavaScriptDateFieldConverter: JsonFieldConverter {
    public typealias T = Date
    
    private static let twitterDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        return f
    }()

    public static func parse(_ parser: JsonParser) -> Date! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return twitterDateFormatter.date(from: str)
    }
    
}


public struct ISO8601DateFieldConverter: JsonFieldConverter {
    public typealias T = Date

    private static let twitterDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return f
    }()

    public static func parse(_ parser: JsonParser) -> Date! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return twitterDateFormatter.date(from: str)
    }

}
