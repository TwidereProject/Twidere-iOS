//
//  SpanItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class SpanItem {
    var start: Int
    var end: Int
    
    var origStart: Int = -1
    var origEnd: Int = -1
    
    var link: String
    
    init(start: Int, end: Int, link: String) {
        self.start = start
        self.end = end
        self.link = link
    }
}