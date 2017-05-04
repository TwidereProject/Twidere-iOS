//
//  Enum+Transform.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import ObjectMapper

class MediaTypeTransform: TransformType {
    typealias Object = MediaItem.MediaType
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> MediaItem.MediaType? {
        if let string = value as? String , !string.isEmpty {
            return MediaItem.MediaType(rawValue: string.lowercasingFirstLetter())
        }
        return nil
    }
    
    func transformToJSON(_ value: MediaItem.MediaType?) -> String? {
        if let userKey = value {
            return userKey.rawValue
        }
        return nil
    }
    
}
