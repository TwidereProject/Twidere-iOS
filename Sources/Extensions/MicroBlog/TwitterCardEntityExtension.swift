//
//  TwitterCardEntityExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension TwitterCardEntity {
    func toPersistable(accountKey: UserKey, accountType: AccountDetails.AccountType?) -> PersistableCardEntity {
        let obj = PersistableCardEntity()
        return obj
    }
}