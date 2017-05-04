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
                let parser = JsonParser(JSON.parser(for: data))
                return .success(self.parse(parser))
            }
            return .failure(MicroBlogError.networkError)
        }
    }
}

public let OAuthTokenResponseSerializer = DataResponseSerializer { req, resp, data, err -> Result<OAuthToken> in
    var oauthToken = "", oauthTokenSecret = "", userId = "", screenName = ""
    for paramString in String(data: data!, encoding: .utf8)!.components(separatedBy: "&") {
        
        if (paramString.contains("=")) {
            let param = paramString.components(separatedBy: "=").map { s -> String in
                return s.removingPercentEncoding!
            }
            if (param.count == 2) {
                switch (param[0]) {
                case "oauth_token":
                    oauthToken = param[1]
                case "oauth_token_secret":
                    oauthTokenSecret = param[1]
                case "user_id":
                    userId = param[1]
                case "screen_name":
                    screenName = param[1]
                default: break
                }
            }
        }
    }
    let token = OAuthToken(oauthToken, oauthTokenSecret)
    token.userId = userId
    token.screenName = screenName
    return .success(token)
}

public let StatusCodeResponseSerializer: DataResponseSerializer<Int> = DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<Int> in
    if let resp = resp {
        return .success(resp.statusCode)
    } else if err != nil {
        return .failure(err!)
    }
    return .failure(MicroBlogError.networkError)
}
