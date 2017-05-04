//
//  TwitterUserEntities.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class UserEntities {
    
    // sourcery: jsonField=url
    var url: Entities!
    
    // sourcery: jsonField=description
    var description: Entities!
    
    
    required init() {
        
    }
}
