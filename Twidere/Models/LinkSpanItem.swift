//
//  SpanItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss

class LinkSpanItem: Glossy {
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
    
    required init?(json: JSON) {
        self.start = "start" <~~ json ?? -1
        self.end = "end" <~~ json ?? -1
        self.link = "link" <~~ json  ?? ""
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> self.start,
            "end" ~~> self.end,
            "link" ~~> self.link
        ])
    }
}