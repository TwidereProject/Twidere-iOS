//
//  CreateFavoriteTask.swift
//  TwidereCore
//
//  Created by Mariotaku Lee on 2017/6/7.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PromiseKit
import RestClient
import MicroBlog
import Mastodon

public class CreateFavoriteTask: AbsAccountRequestTask<Any, PersistableStatus, AnyObject> {
    
    let status: PersistableStatus
    
    required public init(accountKey: UserKey!, status: PersistableStatus) {
        self.status = status
        super.init(accountKey: accountKey)
    }
    
    override open func createTaskPromise(account: AccountDetails) -> Promise<PersistableStatus> {
        switch account.type {
        case .mastodon:
            let service = account.getService(endpointConfig: EndpointConfig.twitter, type: StatusesResourcesRestImpl.self)
            return service.favouriteStatus(id: status.id).then { $0.toPersistable(details: account) }
        default:
            let service = account.getService(endpointConfig: EndpointConfig.twitter, type: FavoritesAPIRestImpl.self)
            return service.createFavorite(id: status.id).then { $0.toPersistable(details: account) }
        }
    }
    
}
