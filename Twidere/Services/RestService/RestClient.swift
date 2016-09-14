//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import Alamofire
import PromiseKit

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
    
    func makeTypedRequest<T: ResponseSerializerType>(_ method: Alamofire.Method,
                          path: String,
                          headers: [String: String]? = nil,
                          queries:[String: String]? = nil,
                          params: [String: AnyObject]? = nil,
                          requestBody:NSData? = nil,
                          authOverride: Authorization? = nil,
                          validation: Request.Validation? = nil,
                          serializer: T) -> Promise<T.SerializedObject> {
        return Promise { fullfill, reject in
            let url = constructUrl(path, queries: queries)
            let finalAuth: Authorization? = authOverride ?? auth
            let isMultipart = params?.contains { (k, v) -> Bool in v is NSData } ?? false
            var finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: params, auth: finalAuth, isMultipart: isMultipart)
            let completionHandler: (Response<T.SerializedObject, T.ErrorObject>) -> Void = { response in
                switch response.result {
                case .Success(let value):
                    fullfill(value)
                case .Failure(let error):
                    reject(error)
                }
            }
            let request: Request
            if (isMultipart) {
                let multipart = MultipartFormData()
                params?.forEach{ (k, v) in
                    if (v is NSData) {
                        multipart.appendBodyPart(data: v as! NSData, name: k, mimeType: "application/octet-stream")
                    } else {
                        multipart.appendBodyPart(data: "\(v)".dataUsingEncoding(NSUTF8StringEncoding)!, name: k)
                    }
                }
                finalHeaders["Content-Type"] = multipart.contentType
                request = Alamofire.upload(method, url, headers: finalHeaders, data: try! multipart.encode())
            } else {
                request = Alamofire.request(method, url, parameters: params, encoding: .Custom(self.restEncoding), headers: finalHeaders)
            }
            if (validation != nil) {
                request.validate(validation!)
            }
            request.response(responseSerializer: serializer, completionHandler: completionHandler)
        }
    }
    
    fileprivate func constructUrl(_ path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    fileprivate func constructHeaders(_ method: Alamofire.Method,
                                  path: String,
                                  headers: [String: String]? = nil,
                                  queries: [String: String]? = nil,
                                  forms: [String:AnyObject]? = nil,
                                  auth: Authorization?,
                                  isMultipart: Bool) -> [String: String] {
        var mergedHeaders = [String: String]()
        if (headers != nil) {
            for (k, v) in headers! {
                mergedHeaders[k] = v
            }
        }
        if (auth != nil && auth!.hasAuthorization) {
            mergedHeaders["Authorization"] = auth!.getHeader(method.rawValue, endpoint: endpoint, path: path, queries: queries, forms: isMultipart ? nil : forms)!
        }
        if (userAgent != nil) {
            mergedHeaders["User-Agent"] = userAgent!
        }
        return mergedHeaders
    }
    
    fileprivate func restEncoding(_ urlRequest: URLRequestConvertible, params: [String: AnyObject]?) -> (NSMutableURLRequest, NSError?) {
        
        let queryUrlEncodeAllowedSet: NSCharacterSet = {
            let allowed = NSMutableCharacterSet.alphanumericCharacterSet()
            allowed.addCharactersInString("-._ ")
            return allowed
        }()
        
        func escape(_ str: String) -> String {
            return str.stringByAddingPercentEncodingWithAllowedCharacters(queryUrlEncodeAllowedSet)!.stringByReplacingOccurrencesOfString(" ", withString: "+")
        }
        
        let request: NSMutableURLRequest = urlRequest.URLRequest
        if (params == nil) {
            return (request, nil)
        }
        let method = Alamofire.Method(rawValue: request.HTTPMethod)
        let paramInUrl = method == .GET || method == .HEAD || method == .DELETE
        if (paramInUrl) {
            let url = NSURLComponents(URL: request.URL!, resolvingAgainstBaseURL: false)
            url?.queryItems = params!.map { k, v -> NSURLQueryItem in
                return NSURLQueryItem(name: k, value: "\(v)")
            }
        } else {
            request.addValue("application/x-www-form-urlencoded; encoding=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = params!.map { k, v -> String in
                return escape(k) + "=" + escape(String(v))
                }.joinWithSeparator("&").dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        }
        return (request, nil)
    }
    
    internal class StatelessCookieStorage: NSHTTPCookieStorage {
        override func cookiesForURL(_ URL: NSURL) -> [NSHTTPCookie]? {
            return nil
        }
        
        override func setCookie(_ cookie: NSHTTPCookie) {
            // No-op
        }
        
        override func setCookies(_ cookies: [NSHTTPCookie], forURL URL: NSURL?, mainDocumentURL: NSURL?) {
            // No-op
        }
        
        override func storeCookies(_ cookies: [NSHTTPCookie], forTask task: NSURLSessionTask) {
            // No-op
        }
    }
 
}

enum RestError: Error {
    case networkError(err: NSError?)
    case requestError(statusCode: Int)
}

extension NSHTTPURLResponse {
    var ok: Bool {
        get {
            return statusCode >= 200 && statusCode < 300
        }
    }
}
