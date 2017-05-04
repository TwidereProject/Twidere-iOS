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
    // sourcery: jsonField=url
    var url: String!
    // sourcery: jsonField=imageurl
    var imageUrl: String!
    // sourcery: jsonField=thumburl
    var thumbUrl: String!
    // sourcery: jsonField=largeurl
    var largeUrl: String!
 
    required init() {
        
    }
}
