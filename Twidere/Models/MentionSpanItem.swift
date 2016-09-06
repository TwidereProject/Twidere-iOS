//
//  UserMention.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss

class MentionSpanItem: Glossy {
    var start: Int = -1
    var end: Int = -1
    
    var key: UserKey
    var name: String? = nil
    var screenName: String? = nil
    
    init(start: Int, end: Int, key: UserKey) {
        self.start = start
        self.end = end
        self.key = key
    }
    
    required init?(json: JSON) {
        self.start = "start" <~~ json ?? -1
        self.end = "end" <~~ json ?? -1
        self.key = UserKey(rawValue: ("key" <~~ json)!)
        self.name = "name" <~~ json
        self.screenName = "screen_name" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> self.start,
            "end" ~~> self.end,
            "key" ~~> self.key.string,
            "name" ~~> self.name,
            "screen_name" ~~> self.screenName
            ])
    }
}