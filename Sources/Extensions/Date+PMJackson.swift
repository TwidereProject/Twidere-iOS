//
//  Date+PMJackson.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Date {
    
    static func parseTwitterDate(_ parser: PMJacksonParser) -> Date! {
        return parseTwitterDate(parser.getValueAsString())
    }
    
    static func parseTwitterDate(_ string: String?) -> Date! {
        return parseTwitterDate(string)
    }
    
}
