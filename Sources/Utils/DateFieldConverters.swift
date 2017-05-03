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
    
    static func parse(_ parser: PMJacksonParser) -> Date! {
         return parseTwitterDate(parser.getValueAsString())
    }
}
