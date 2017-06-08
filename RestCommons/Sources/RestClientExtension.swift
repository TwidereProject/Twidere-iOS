//
// Created by Mariotaku Lee on 2017/6/8.
// Copyright (c) 2017 Mariotaku Lee. All rights reserved.
//

import Foundation
import RestClient

public extension Endpoint {

    public func getService<T:RestAPIProtocol>(auth: Authorization!, type: T.Type) -> T {
        let client = RestClient(endpoint: self, auth: auth)
        return type.init(client: client)
    }

}