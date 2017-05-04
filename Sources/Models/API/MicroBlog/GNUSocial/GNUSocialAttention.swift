//
//  GNUSocialAttention.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class GNUSocialAttention {
    // sourcery: jsonField=fullname
    var fullName: String!
    // sourcery: jsonField=id
    var id: String!
    // sourcery: jsonField=ostatus_uri
    var ostatusUri: String!
    // sourcery: jsonField=profileurl
    var profileUrl: String!
    // sourcery: jsonField=screen_name
    var screenName: String!
    
    required init() {
        
    }
}
