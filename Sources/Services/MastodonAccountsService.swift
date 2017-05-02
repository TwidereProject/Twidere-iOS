//
//  MastodonAccountsService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
protocol MastodonAccountsServices {
    
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/accounts/\(id)
    // sourcery: restSerializer=parseJsonMapperResponse(MastodonAccountJsonMapper.singleton, MastodonAccount())
    func getAccount(id: String) -> Promise<MastodonAccount>
    
}
