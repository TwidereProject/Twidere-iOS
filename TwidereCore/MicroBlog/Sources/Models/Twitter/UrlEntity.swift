//
//  URLEntity.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class UrlEntity {
    
    // sourcery: jsonField=url
    var url: String!
    // sourcery: jsonField=display_url
    var displayUrl: String!
    // sourcery: jsonField=expanded_url
    var expandedUrl: String!
    
    // sourcery: jsonField=indices
    var indices: [Int32]!
    
    required init() {
        
    }
}
