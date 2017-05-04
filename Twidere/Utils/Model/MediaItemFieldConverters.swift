//
//  MediaItemFieldConverters.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

import PMJackson

struct MediaItemTypeFieldConverter: JsonFieldConverter {
    typealias T = MediaItem.MediaType
    
    static func parse(_ parser: PMJacksonParser) -> MediaItem.MediaType! {
        return MediaItem.MediaType(rawValue: parser.getValueAsString())
    }
}
