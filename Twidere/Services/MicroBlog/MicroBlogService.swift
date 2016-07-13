//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Just

class MicroBlogService: RestClient {
    
    func verifyCredentials() throws -> JSON {
        return try makeTypedRequest(.GET, path: "/account/verify_credentials.json", checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    static func checkRequest(result: HttpResult) throws {
        if (!(result.response?.ok ?? false)) {
            if let data = result.data {
                let json = JSON(data)
                let code = json["errors"][0]["code"].int ?? -1
                let message = json["errors"][0]["message"].string
                throw MicroBlogError.RequestError(code: code, message: message)
            }
        }
    }
    
    static func convertJSON(result: HttpResult) -> JSON {
        return SwiftyJSON.JSON(data: result.data!)
    }
}

enum MicroBlogError: ErrorType {
    case RequestError(code: Int, message: String?)
}