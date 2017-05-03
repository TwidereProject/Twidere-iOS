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
    // sourcery: jsonFieldName=fullname
    var fullName: String!
    // sourcery: jsonFieldName=id
    var id: String!
    // sourcery: jsonFieldName=ostatus_uri
    var ostatusUri: String!
    // sourcery: jsonFieldName=profileurl
    var profileUrl: String!
    // sourcery: jsonFieldName=screen_name
    var screenName: String!
    
    required init() {
        
    }
}
