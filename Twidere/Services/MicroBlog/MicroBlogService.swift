//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Just

class MicroBlogService {
    
    let endpoint: Endpoint
    let auth: Authorization?
    let userAgent: String?
    
    init(endpoint: Endpoint, auth: Authorization?, userAgent: String? = nil) {
        self.endpoint = endpoint
        self.auth = auth
        self.userAgent = userAgent
    }
    
    func verifyCredentials(callback:((HTTPResult!) -> Void)? = nil) -> HTTPResult {
        return makeRequest(.GET, path: "/account/verify_credentials.json", asyncCompletionHandler: callback)
    }
    
    private func makeRequest(method: HTTPMethod,
                             path: String,
                             headers: [String: String] = [:],
                             queries:[String: String] = [:],
                             forms: [String: AnyObject] = [:],
                             json:AnyObject? = nil,
                             files:[String:HTTPFile] = [:],
                             URLQuery:String? = nil,
                             requestBody:NSData? = nil,
                             asyncProgressHandler:((HTTPProgress!) -> Void)? = nil,
                             asyncCompletionHandler:((HTTPResult!) -> Void)? = nil) -> HTTPResult {
        let url = constructUrl(path, queries: queries)
        let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: forms)
        return Just.request(method, URLString: url, params: queries, data: forms, json: json, headers: finalHeaders, files: files, allowRedirects: false, requestBody: requestBody, asyncProgressHandler: asyncProgressHandler, asyncCompletionHandler: asyncCompletionHandler)
     
    }
    
    private func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    private func constructHeaders(method: HTTPMethod,
                                  path: String,
                                  headers: [String: String],
                                  queries: [String: String],
                                  forms: [String:AnyObject]) -> [String: String] {
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