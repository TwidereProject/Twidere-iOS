//
//  StatusesService.swift
//  Mastodon
//
//  Created by Mariotaku Lee on 2017/6/7.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
protocol StatusesResources {
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/statuses/\(id)
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func fetchStatus(/* sourcery: param=id */id: String) -> Promise<Status>
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/statuses/\(id)/context
    // sourcery: restSerializer=ContextJsonMapper.singleton.responseSerializer
    func getStatusContext(/* sourcery: param=id */id: String) -> Promise<Context>
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/statuses/\(id)/card
    // sourcery: restSerializer=CardJsonMapper.singleton.responseSerializer
    func getStatusCard(/* sourcery: param=id */id: String) -> Promise<Card>
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/statuses/\(id)/reblogged_by
    // sourcery: restSerializer=AccountJsonMapper.singleton.linkHeaderListResponseSerializer
    func getStatusRebloggedBy(/* sourcery: param=id */id: String) -> Promise<LinkHeaderList<Account>>
    // sourcery: restMethod=GET
    // sourcery: restPath=/v1/statuses/\(id)/favourited_by
    // sourcery: restSerializer=AccountJsonMapper.singleton.linkHeaderListResponseSerializer
    func getStatusFavouritedBy(/* sourcery: param=id */id: String) -> Promise<LinkHeaderList<Account>>
    // sourcery: restMethod=POST
    // sourcery: restPath=/v1/statuses
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    // TODO: use multiple params at once
    func postStatus(/* sourcery: param=update */update: StatusUpdate) -> Promise<Status>
    // sourcery: restMethod=DELETE
    // sourcery: restPath=/v1/statuses/\(id)
    // sourcery: restSerializer=nil
    func deleteStatus(/* sourcery: param=id */id: String) -> Promise<Int>
    // sourcery: restMethod=POST
    // sourcery: restPath=/v1/statuses/\(id)/reblog
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func reblogStatus(/* sourcery: param=id */id: String) -> Promise<Status>
    // sourcery: restMethod=POST
    // sourcery: restPath=/v1/statuses/\(id)/unreblog
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func unreblogStatus(/* sourcery: param=id */id: String) -> Promise<Status>
    // sourcery: restMethod=POST
    // sourcery: restPath=/v1/statuses/\(id)/favourite
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func favouriteStatus(/* sourcery: param=id */id: String) -> Promise<Status>
    // sourcery: restMethod=POST
    // sourcery: restPath=/v1/statuses/\(id)/unfavourite
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func unfavouriteStatus(/* sourcery: param=id */id: String) -> Promise<Status>
    
}
