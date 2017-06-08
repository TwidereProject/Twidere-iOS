//
//  MastodonAccountsService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
public protocol AccountsAPI {
    
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/accounts/\(id)
    // sourcery: restSerializer=AccountJsonMapper.singleton.responseSerializer
    func getAccount(id: String) -> Promise<Account>
    
}
