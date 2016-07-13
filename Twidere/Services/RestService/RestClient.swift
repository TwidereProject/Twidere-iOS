//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Alamofire
import Alamofire_Synchronous

typealias HttpResult = (request: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?)

class RestClient {
    
    let endpoint: Endpoint
    let auth: Authorization?
    let userAgent: String?
    
    init(endpoint: Endpoint, auth: Authorization? = nil, userAgent: String? = nil) {
        self.endpoint = endpoint
        self.auth = auth
        self.userAgent = userAgent
    }
    
    func makeTypedRequest<T>(method: Alamofire.Method,
                          path: String,
                          headers: [String: String]? = nil,
                          queries:[String: String]? = nil,
                          forms: [String: AnyObject]? = nil,
                          requestBody:NSData? = nil,
                          authOverride: Authorization? = nil,
                          checker: ((HttpResult) throws -> Void)? = nil,
                          converter: ((HttpResult) -> T)) throws -> T {
        let result = makeRequest(method, path: path, headers: headers, queries: queries, params: forms, authOverride: authOverride)
        if (result.error != nil) {
            throw RestError.NetworkError(err: result.error)
        } else if (checker != nil) {
            try checker!(result)
        } else if (!(result.response?.ok ?? false)) {
            throw RestError.RequestError(statusCode: result.response!.statusCode)
        }
        return converter(result)
    }
    
    func makeRequest(method: Alamofire.Method,
                             path: String,
                             headers: [String: String]? = nil,
                             queries:[String: String]? = nil,
                             params: [String: AnyObject]? = nil,
                             authOverride: Authorization? = nil) -> HttpResult {
        let url = constructUrl(path, queries: queries)
        let finalAuth: Authorization? = authOverride ?? auth
        let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: params, auth: finalAuth)
        
        return Alamofire.request(method, url, parameters: params, encoding: .URL, headers: finalHeaders).response()
    }
    
    private func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    private func constructHeaders(method: Alamofire.Method,
                                  path: String,
                                  headers: [String: String]? = nil,
                                  queries: [String: String]? = nil,
                                  forms: [String:AnyObject]? = nil,
                                  auth: Authorization?) -> [String: String] {
        var mergedHeaders = [String: String]()
        if (headers != nil) {
            for (k, v) in headers! {
                mergedHeaders[k] = v
            }
        }
        if (auth != nil && auth!.hasAuthorization) {
            mergedHeaders["Authorization"] = auth!.getHeader(method.rawValue, endpoint: endpoint, path: path, queries: queries, forms: forms)!
        }
        if (userAgent != nil) {
            mergedHeaders["User-Agent"] = userAgent!
        }
        return mergedHeaders
    }
    
    internal class StatelessCookieStorage: NSHTTPCookieStorage {
        override func cookiesForURL(URL: NSURL) -> [NSHTTPCookie]? {
            return nil
        }
        
        override func setCookie(cookie: NSHTTPCookie) {
            // No-op
        }
        
        override func setCookies(cookies: [NSHTTPCookie], forURL URL: NSURL?, mainDocumentURL: NSURL?) {
            // No-op
        }
        
        override func storeCookies(cookies: [NSHTTPCookie], forTask task: NSURLSessionTask) {
            // No-op
        }
    }
    
    func isOk(result: NSHTTPURLResponse?) {
        return
    }
}

enum RestError: ErrorType {
    case NetworkError(err: NSError?)
    case RequestError(statusCode: Int)
}

extension NSHTTPURLResponse {
    var ok: Bool {
        get {
            return statusCode >= 200 && statusCode < 300
        }
    }
}