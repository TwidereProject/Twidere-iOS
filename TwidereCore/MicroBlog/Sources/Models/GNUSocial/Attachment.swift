//
//  GNUSocialAttachment.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

// sourcery: jsonParse
public class Attachment {
    // sourcery: jsonField=width
    public var width: Int32 = 0
    // sourcery: jsonField=height
    public var height: Int32 = 0
    // sourcery: jsonField=url
    public var url: String!
    // sourcery: jsonField=thumb_url
    public var thumbUrl: String!
    // sourcery: jsonField=large_thumb_url
    public var largeThumbUrl: String!
    // sourcery: jsonField=mimetype
    public var mimetype: String!
    // sourcery: jsonField=id
    public var id: Int64 = -1
    // sourcery: jsonField=oembed
    public var oembed: Bool = false
    // sourcery: jsonField=size
    public var size: Int64 = -1
    // sourcery: jsonField=version
    public var version: String!
    
    required public init() {
        
    }
}
