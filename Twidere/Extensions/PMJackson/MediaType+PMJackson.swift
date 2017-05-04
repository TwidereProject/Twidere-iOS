//
//  MediaType+PMJackson.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson

extension MediaItem.MediaType {
    
    static func parse(_ parser: PMJacksonParser) -> MediaItem.MediaType! {
        guard let str = parser.getValueAsString() else {
            return nil
        }
        return MediaItem.MediaType(rawValue: str)
    }
    
}
