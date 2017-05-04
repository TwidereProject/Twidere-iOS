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
    // sourcery: jsonField=width
    var width: Int32 = 0
    // sourcery: jsonField=height
    var height: Int32 = 0
    // sourcery: jsonField=url
    var url: String!
    // sourcery: jsonField=thumb_url
    var thumbUrl: String!
    // sourcery: jsonField=large_thumb_url
    var largeThumbUrl: String!
    // sourcery: jsonField=mimetype
    var mimetype: String!
    // sourcery: jsonField=id
    var id: Int64 = -1
    // sourcery: jsonField=oembed
    var oembed: Bool = false
    // sourcery: jsonField=size
    var size: Int64 = -1
    // sourcery: jsonField=version
    var version: String!
    
    required init() {
        
    }
}
