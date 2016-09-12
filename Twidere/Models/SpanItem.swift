//
//  SpanItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class SpanItem: CustomDebugStringConvertible {
    var start: Int = -1
    var end: Int = -1
    
    var origStart: Int = -1
    var origEnd: Int = -1
    
    init() {
        
    }
    
    var debugDescription: String {
        return "\(Mirror(reflecting: self).subjectType)(origStart: \(origStart), origEnd: \(origEnd), start: \(start), end: \(end))"
    }
}

class LinkSpanItem: SpanItem {

    var display: String? = nil
    
    var link: String
    
    init(display: String, link: String) {
        self.display = display
        self.link = link
        super.init()
    }

}

class MentionSpanItem: SpanItem {
 
    var key: UserKey
    var name: String? = nil
    var screenName: String? = nil
    
    init(key: UserKey) {
        self.key = key
        super.init()
    }

}

class HashtagSpanItem: SpanItem {
    var hashtag: String
    
    init(hashtag: String) {
        self.hashtag = hashtag
        super.init()
    }
    
}