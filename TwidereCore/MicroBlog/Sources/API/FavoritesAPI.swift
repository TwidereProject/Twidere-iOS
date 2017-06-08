//
//  FavoritesAPI.swift
//  MicroBlog
//
//  Created by Mariotaku Lee on 2017/6/6.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
public protocol FavoritesAPI {
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/favorites/create.json
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func createFavorite(/* sourcery: param=id*/id: String) -> Promise<Status>
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/favorites/destroy.json
    // sourcery: restSerializer=StatusJsonMapper.singleton.responseSerializer
    func destroyFavorite(/* sourcery: param=id*/id: String) -> Promise<Status>
    
}
