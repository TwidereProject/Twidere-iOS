//
//  ModelConverter.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Alamofire
import RestCommons
import RestClient
import PMJackson
import PMJSON

public extension JsonMapper where T: JsonMappable {

    var linkHeaderListResponseSerializer: DataResponseSerializer<LinkHeaderList<T>> {
        return DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<LinkHeaderList<T>> in
            if err != nil, let resp = resp {
                return .failure(RestError.requestError(code: resp.statusCode, message: nil))
            } else if let data = data {
                let parser = JsonParser(JSON.parser(for: data))
                let list = LinkHeaderList(data: self.parseArray(parser))
                return .success(list)
            }
            return .failure(RestError.networkError)
        }
    }
}
