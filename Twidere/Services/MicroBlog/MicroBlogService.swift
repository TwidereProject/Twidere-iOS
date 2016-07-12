//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Just

class MicroBlogService: RestClient {
    
    func verifyCredentials() -> HTTPResult {
        return makeRequest(.GET, path: "/account/verify_credentials.json")
    }
    
}