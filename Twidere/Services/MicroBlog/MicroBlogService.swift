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
    
    static func checkRequest(result: HTTPResult!) throws {
        if (!result.ok) {
            let json = JSON(result.json!)
            let code = json["errors"][0]["code"].int ?? -1
            let message = json["errors"][0]["message"].string
            throw MicroBlogError.RequestError(code: code, message: message)
        }
    }
    
    static func convertJSON(result: HTTPResult!) -> JSON {
        return SwiftyJSON.JSON(data: result.content!)
    }
}

enum MicroBlogError: ErrorType {
    case RequestError(code: Int, message: String?)
}