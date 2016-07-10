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
    
    init(endpoint: Endpoint, auth: Authorization?, userAgent: String? = nil) {
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
                          converter: ((HTTPResult!) -> T),
                          callback: ((result: T?, error: NSError?) -> Void)? = nil) -> T? {
        if (callback != nil) {
            makeRequest(method, path: path, headers: headers, queries: queries,forms: forms, json: json, files: files,requestBody: requestBody, authOverride: authOverride) { result -> Void in
                if (result.ok) {
                    callback!(result: converter(result), error: nil)
                } else {
                    callback!(result: nil, error: result.error)
                }
            }
            return nil
        }
        let result = makeRequest(method, path: path, headers: headers, queries: queries,forms: forms,json: json,files: files,requestBody: requestBody, authOverride: authOverride)
        if (result.ok) {
            return converter(result)
        }
        return nil
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
                             asyncProgressHandler:((HTTPProgress!) -> Void)? = nil,
                             asyncCompletionHandler:((HTTPResult!) -> Void)? = nil) -> HTTPResult {
        let url = constructUrl(path, queries: queries)
        let finalAuth: Authorization? = authOverride ?? auth
        let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: forms, auth: finalAuth)
        return Just.request(method, URLString: url, params: queries, data: forms, json: json, headers: finalHeaders, files: files, cookies: [:], allowRedirects: false, requestBody: requestBody, asyncProgressHandler: asyncProgressHandler, asyncCompletionHandler: asyncCompletionHandler)
        
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