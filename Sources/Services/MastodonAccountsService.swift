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
    func getAccount(id: String) -> Promise<MastodonAccount>
    
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/accounts/search
    func searchAccounts(/* sourcery: query=q */query: String) -> Promise<MastodonAccount>
}
