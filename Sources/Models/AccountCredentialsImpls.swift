//
//  AccountOAuthCredentials.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/4.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery:jsonParse
class AccountOAuthCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=consumer_key
    var consumer_key: String!
    // sourcery: jsonField=consumer_secret
    var consumer_secret: String!
    
    // sourcery: jsonField=access_token
    var access_token: String!
    // sourcery: jsonField=access_token_secret
    var access_token_secret: String!
    
    // sourcery: jsonField=same_oauth_signing_url
    var same_oauth_signing_url: Bool = false
    
    required init() {
        
    }
    
}

// sourcery:jsonParse
class AccountOAuth2Credentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=access_token
    var access_token: String!
    
    required init() {
        
    }
}

// sourcery:jsonParse
class AccountBasicCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=username
    var username: String!
    // sourcery: jsonField=password
    var password: String!
    
    required init() {
        
    }
}

// sourcery:jsonParse
class AccountEmptyCredentials: AccountDetails.Credentials {
    
    required init() {
        
    }
}
