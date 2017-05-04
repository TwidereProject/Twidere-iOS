//
//  UserKeyFieldConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson
import MicroBlog

public class UserKeyFieldConverter: JsonFieldConverter {
    public typealias T = UserKey
    
    public static func parse(_ parser: JsonParser) -> UserKey! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return UserKey(stringLiteral: str)
    }
}

public class GeoLocationFieldConverter: JsonFieldConverter {
    public typealias T = GeoLocation
    
    public static func parse(_ parser: JsonParser) -> GeoLocation! {
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
        return GeoLocation(latitude: lat, longitude: lng)
    }
    
}

public struct MediaItemTypeFieldConverter: JsonFieldConverter {
    public typealias T = MediaItem.MediaType
    
    public static func parse(_ parser: JsonParser) -> MediaItem.MediaType! {
        return MediaItem.MediaType(rawValue: parser.getValueAsString())
    }
}
