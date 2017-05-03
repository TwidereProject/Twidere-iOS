//
//  FanfouPhoto.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class FanfouPhoto {
    // sourcery: jsonFieldName=url
    var url: String!
    // sourcery: jsonFieldName=imageurl
    var imageUrl: String!
    // sourcery: jsonFieldName=thumburl
    var thumbUrl: String!
    // sourcery: jsonFieldName=largeurl
    var largeUrl: String!
 
    required init() {
        
    }
}
