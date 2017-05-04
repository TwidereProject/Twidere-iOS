//
//  FanfouPhoto.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
public class Photo {
    // sourcery: jsonField=url
    public var url: String!
    // sourcery: jsonField=imageurl
    public var imageUrl: String!
    // sourcery: jsonField=thumburl
    public var thumbUrl: String!
    // sourcery: jsonField=largeurl
    public var largeUrl: String!
 
    required public init() {
        
    }
}
