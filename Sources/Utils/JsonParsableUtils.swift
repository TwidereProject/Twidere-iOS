//
//  JsonParsableUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Alamofire
import PMJackson
import PMJSON


func parseJsonMapperResponse<T>(_ mapper: JsonMapper<T>, _ instance: T) -> DataResponseSerializer<T> {
    return DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<T> in
        if err != nil, let resp = resp {
//            if let data = data {
//                let json = JSON.decode(data)
//                let errors = json["errors"].map({ (_, error) -> MicroBlogError.ErrorInfo in
//                    return MicroBlogError.ErrorInfo(code: error["code"].intValue, name: error["name"].string, message: error["message"].stringValue)
//                })
//                if (!errors.isEmpty) {
//                    return .failure(MicroBlogError.serviceError(errors: errors))
//                }
//            }
            return .failure(MicroBlogError.requestError(code: resp.statusCode, message: nil))
        } else if let data = data {
            let parser = PMJacksonParser(JSON.parser(for: data))
            return .success(mapper.parse(instance, parser: parser))
        }
        return .failure(MicroBlogError.networkError)
    }
}
