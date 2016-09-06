//
//  HashtagSpanItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

import Foundation
import Gloss

class HashtagSpanItem: Glossy {
    var start: Int
    var end: Int
    
    var hashtag: String
    
    init(start: Int, end: Int, hashtag: String) {
        self.start = start
        self.end = end
        self.hashtag = hashtag
    }
    
    required init?(json: JSON) {
        self.start = "start" <~~ json ?? -1
        self.end = "end" <~~ json ?? -1
        self.hashtag = "hashtag" <~~ json ?? ""
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> self.start,
            "end" ~~> self.end,
            "hashtag" ~~> self.hashtag
            ])
    }
}