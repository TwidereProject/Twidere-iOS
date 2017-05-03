//
//  UserKeyFieldConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson

class UserKeyFieldConverter: JsonFieldConverter {
    typealias T = UserKey
    
    static func parse(_ parser: PMJacksonParser) -> UserKey! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return UserKey(stringLiteral: str)
    }
}

class GeoLocationFieldConverter: JsonFieldConverter {
    typealias T = GeoLocation
    
    static func parse(_ parser: PMJacksonParser) -> (latitude: Double, longitude: Double)! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        let components = str.components(separatedBy: ",")
        if (components.count != 2) {
            return nil
        }
        guard let lat = Double(components[0]), let lng = Double(components[1]) else {
            return nil
        }
        return (lat, lng)
    }
    
}
