//
//  FlatStatusExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss


func < (lhs: FlatStatus, rhs: FlatStatus) -> Bool {
    return lhs.sortId < rhs.sortId
}

func == (lhs: FlatStatus, rhs: FlatStatus) -> Bool {
    return lhs.sortId == rhs.sortId
}

extension FlatStatus {
    
    class Metadata: Glossy {
        var spans: [LinkSpanItem]? = nil
        var mentions: [MentionSpanItem]? = nil
        var hashtags: [HashtagSpanItem]? = nil
        var displayRange: [Int]? = nil
        
        init() {
            
        }
        
        required init?(json: JSON) {
            self.spans = "spans" <~~ json
            self.mentions = "mentions" <~~ json
            self.hashtags = "hashtags" <~~ json
            self.displayRange = "display_range" <~~ json
        }
        
        func toJSON() -> JSON? {
            return jsonify([
                "spans" ~~> self.spans,
                "mentions" ~~> self.mentions,
                "hashtags" ~~> self.hashtags,
                "display_range" ~~> self.displayRange
            ])
        }
    }
}