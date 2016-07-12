//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Just

class RestClient {
    
    let endpoint: Endpoint
    let auth: Authorization?
    let userAgent: String?
    
    init(endpoint: Endpoint, auth: Authorization? = nil, userAgent: String? = nil) {
        self.endpoint = endpoint
        self.auth = auth
        self.userAgent = userAgent
    }
    
    func makeTypedRequest<T>(method: HTTPMethod,
                          path: String,
                          headers: [String: String] = [:],
                          queries:[String: String] = [:],
                          forms: [String: AnyObject] = [:],
                          json:AnyObject? = nil,
                          files:[String:HTTPFile] = [:],
                          requestBody:NSData? = nil,
                          authOverride: Authorization? = nil,
                          cookies: [String: String] = [:],
                          converter: ((HTTPResult!) -> T)) throws -> T {
        let result = makeRequest(method, path: path, headers: headers, queries: queries,forms: forms,json: json,files: files,requestBody: requestBody, authOverride: authOverride, cookies: cookies)
        if (result.ok) {
            return converter(result)
        } else if (result.error != nil) {
            throw RestError.NetworkError(err: result.error)
        }
        throw RestError.RequestError(statusCode: result.statusCode ?? -1)
    }
    
    func makeRequest(method: HTTPMethod,
                             path: String,
                             headers: [String: String] = [:],
                             queries:[String: String] = [:],
                             forms: [String: AnyObject] = [:],
                             json:AnyObject? = nil,
                             files:[String:HTTPFile] = [:],
                             requestBody:NSData? = nil,
                             authOverride: Authorization? = nil,
                             cookies: [String: String] = [:]) -> HTTPResult {
        let url = constructUrl(path)
        let finalAuth: Authorization? = authOverride ?? auth
        let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: forms, auth: finalAuth)
        return Just.request(method, URLString: url, params: queries, data: forms, json: json, headers: finalHeaders, files: files, cookies: cookies, allowRedirects: false, requestBody: requestBody)
        
    }
    
    private func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    private func constructHeaders(method: HTTPMethod,
                                  path: String,
                                  headers: [String: String],
                                  queries: [String: String],
                                  forms: [String:AnyObject],
                                  auth: Authorization?) -> [String: String] {
        var mergedHeaders = [String: String]()
        for (k, v) in headers {
            mergedHeaders[k] = v
        }
        if (auth != nil && auth!.hasAuthorization) {
            mergedHeaders["Authorization"] = auth!.getHeader(String(method), endpoint: endpoint, path: path, queries: queries, data: forms)!
        }
        if (userAgent != nil) {
            mergedHeaders["User-Agent"] = userAgent!
        }
        return mergedHeaders
    }
    
}

enum RestError: ErrorType {
    case NetworkError(err: NSError?)
    case RequestError(statusCode: Int)
}