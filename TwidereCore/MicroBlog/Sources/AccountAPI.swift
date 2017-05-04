//
//  TwitterAccountService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
protocol AccountAPI {
    
    // sourcery: restMethod=GET
    // sourcery: restPath=/account/verify_credentials.json
    // sourcery: restSerializer=UserJsonMapper.singleton.responseSerializer
    func verifyCredentials() -> Promise<User>
    
}
