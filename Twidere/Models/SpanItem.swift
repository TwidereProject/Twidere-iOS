//
//  SpanItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss

class SpanItem: CustomDebugStringConvertible {
    var start: Int = -1
    var end: Int = -1
    
    var origStart: Int = -1
    var origEnd: Int = -1
    
    init() {
        
    }
    
    init?(json: JSON) {
        self.start = "start" <~~ json ?? -1
        self.end = "end" <~~ json ?? -1
    }
    
    var debugDescription: String {
        return "\(Mirror(reflecting: self).subjectType)(origStart: \(origStart), origEnd: \(origEnd), start: \(start), end: \(end))"
    }
}

class LinkSpanItem: SpanItem, Glossy {

    var display: String? = nil
    
    var link: String
    
    init(display: String, link: String) {
        self.display = display
        self.link = link
        super.init()
    }
    
    required override init?(json: JSON) {
        self.link = "link" <~~ json  ?? ""
        super.init(json: json)
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> super.start,
            "end" ~~> super.end,
            "link" ~~> self.link
            ])
    }
}

class MentionSpanItem: SpanItem, Glossy {
 
    var key: UserKey
    var name: String? = nil
    var screenName: String? = nil
    
    init(key: UserKey) {
        self.key = key
        super.init()
    }
    
    required override init?(json: JSON) {
        self.key = UserKey(rawValue: ("key" <~~ json)!)
        self.name = "name" <~~ json
        self.screenName = "screen_name" <~~ json
        super.init(json: json)
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> super.start,
            "end" ~~> super.end,
            "key" ~~> self.key.string,
            "name" ~~> self.name,
            "screen_name" ~~> self.screenName
            ])
    }
}

class HashtagSpanItem: SpanItem, Glossy {
    var hashtag: String
    
    init(hashtag: String) {
        self.hashtag = hashtag
        super.init()
    }
    
    required override init?(json: JSON) {
        self.hashtag = "hashtag" <~~ json ?? ""
        super.init(json: json)
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "start" ~~> super.start,
            "end" ~~> super.end,
            "hashtag" ~~> self.hashtag
            ])
    }
}