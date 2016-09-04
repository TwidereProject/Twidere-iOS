//
//  FlatStatusExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss

extension FlatStatus {
    
    class Metadata: Glossy {
        var spans: [SpanItem]? = nil
        var displayRange: [Int]? = nil
        
        init() {
            
        }
        
        required init?(json: JSON) {
            self.spans = "spans" <~~ json
            self.displayRange = "display_range" <~~ json
        }
        
        func toJSON() -> JSON? {
            return jsonify([
                "spans" ~~> self.spans,
                "display_range" ~~> self.displayRange
            ])
        }
    }
}