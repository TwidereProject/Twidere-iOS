//
//  TwitterEntities.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

// sourcery: jsonParse
class Entities {
    
    // sourcery: jsonField=urls
    var urls: [UrlEntity]!
    
    // sourcery: jsonField=hashtags
    var hashtags: [HashtagEntity]!
    
    // sourcery: jsonField=mentions
    var mentions: [MentionEntity]!
    
    required init() {
        
    }
}
