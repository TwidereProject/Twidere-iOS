//
//  GNUSocialAttachment.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class GNUSocialAttachment {
    // sourcery: jsonFieldName=width
    var width: Int32 = 0
    // sourcery: jsonFieldName=height
    var height: Int32 = 0
    // sourcery: jsonFieldName=url
    var url: String!
    // sourcery: jsonFieldName=thumb_url
    var thumbUrl: String!
    // sourcery: jsonFieldName=large_thumb_url
    var largeThumbUrl: String!
    // sourcery: jsonFieldName=mimetype
    var mimetype: String!
    // sourcery: jsonFieldName=id
    var id: Int64 = -1
    // sourcery: jsonFieldName=oembed
    var oembed: Bool = false
    // sourcery: jsonFieldName=size
    var size: Int64 = -1
    // sourcery: jsonFieldName=version
    var version: String!
    
    init() {
        
    }
}
