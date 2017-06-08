//
// Created by Mariotaku Lee on 2017/6/8.
// Copyright (c) 2017 Mariotaku Lee. All rights reserved.
//

import Foundation
import Mastodon

public extension Status {

    func toPersistable(details: AccountDetails) -> PersistableStatus {
        let obj = toPersistable(accountKey: details.key)
        obj.account_color = details.color
        return obj
    }

    func toPersistable(accountKey: UserKey) -> PersistableStatus {
        let result = PersistableStatus()
        apply(to: result, accountKey: accountKey)
        return result
    }

    func apply(to result: PersistableStatus, accountKey: UserKey) {

    }
}