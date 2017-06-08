//
//  ModelConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Alamofire
import RestClient
import PMJackson
import PMJSON

public extension JsonMapper where T: JsonMappable {
    var responseSerializer: DataResponseSerializer<T> {
        return DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<T> in
            if err != nil, let resp = resp {
                return .failure(RestError.requestError(code: resp.statusCode, message: nil))
            } else if let data = data {
                let parser = JsonParser(JSON.parser(for: data))
                return .success(self.parse(parser))
            }
            return .failure(RestError.networkError)
        }
    }
    
}

public let StatusCodeResponseSerializer: DataResponseSerializer<Int> = DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<Int> in
    if let resp = resp {
        return .success(resp.statusCode)
    } else if err != nil {
        return .failure(err!)
    }
    return .failure(RestError.networkError)
}
