//
//  TwitterEntities.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class TwitterEntities {
    
    // sourcery: jsonField=urls
    var urls: [TwitterURLEntity]!
    
    // sourcery: jsonField=hashtags
    var hashtags: [TwitterHashtagEntity]!
    
    // sourcery: jsonField=mentions
    var mentions: [TwitterMentionEntity]!
    
    required init() {
        
    }
}
