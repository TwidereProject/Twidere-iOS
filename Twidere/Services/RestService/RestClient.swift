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

typealias HttpResult = (request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: NSError?)

class RestClient {
    
    let endpoint: Endpoint
    let auth: Authorization?
    let userAgent: String?
    
    init(endpoint: Endpoint, auth: Authorization? = nil, userAgent: String? = nil) {
        self.endpoint = endpoint
        self.auth = auth
        self.userAgent = userAgent
    }
    
    func makeTypedRequest<T>(_ method: Alamofire.HTTPMethod,
                          path: String,
                          headers: [String: String]? = nil,
                          queries:[String: String]? = nil,
                          params: [String: Any]? = nil,
                          requestBody:Data? = nil,
                          authOverride: Authorization? = nil,
                          validation: DataRequest.Validation? = nil,
                          serializer: DataResponseSerializer<T>) -> Promise<T> {
        return Promise { fullfill, reject in
            let url = constructUrl(path, queries: queries)
            let finalAuth: Authorization? = authOverride ?? auth
            let isMultipart: Bool = params != nil && params!.contains(where: { $0.1 is Data })
            let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, params: params, auth: finalAuth, isMultipart: isMultipart)
            let completionHandler: (DataResponse<T>) -> Void = { response in
                switch response.result {
                case .success(let value):
                    fullfill(value)
                case .failure(let error):
                    reject(error)
                }
            }
            if (isMultipart) {
                //finalHeaders["Content-Type"] = multipart.contentType
                Alamofire.upload(
                    multipartFormData: { multipart in
                        for (k, v) in params! {
                            switch v {
                            case let d as Data:
                                multipart.append(d, withName: k, mimeType: "application/octet-stream")
                            default:
                                multipart.append("\(v)".data(using: String.Encoding.utf8)!, withName: k)
                            }
                        }
                    }, to: url, method: method, headers: finalHeaders,
                       encodingCompletion: { encodingResult in
                        switch encodingResult {
                        case let .success(request, _, _):
                            request.response(responseSerializer: serializer, completionHandler: completionHandler)
                        case let .failure(error):
                            reject(error)
                        }
                })
            } else {
                let request = Alamofire.request(url, method: method, parameters: params, headers: finalHeaders)
                if (validation != nil) {
                    request.validate(validation!)
                } else {
                    request.validate()
                }
                request.response(responseSerializer: serializer, completionHandler: completionHandler)
            }
        }
    }
    
    fileprivate func constructUrl(_ path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    fileprivate func constructHeaders(_ method: HTTPMethod,
                                      path: String,
                                      headers: [String: String]? = nil,
                                      queries: [String: String]? = nil,
                                      params: [String: Any]? = nil,
                                      auth: Authorization?,
                                      isMultipart: Bool) -> [String: String] {
        var mergedHeaders = [String: String]()
        if (headers != nil) {
            for (k, v) in headers! {
                mergedHeaders[k] = v
            }
        }
        if (auth != nil && auth!.hasAuthorization) {
            let forms: [String: String]?
            if (isMultipart) {
                forms = nil
            } else {
                var newForms: [String: String] = [:]
                params?.forEach { (k, v) in
                    newForms[k] = String(describing: v)
                }
                forms = newForms
            }
            mergedHeaders["Authorization"] = auth!.getHeader(method.rawValue, endpoint: endpoint, path: path, queries: queries, forms: forms)!
        }
        if (userAgent != nil) {
            mergedHeaders["User-Agent"] = userAgent!
        }
        return mergedHeaders
    }
    
    fileprivate func restEncoding(_ urlRequest: URLRequestConvertible, params: [String: AnyObject]?) -> (URLRequest, NSError?) {
        
        let queryUrlEncodeAllowedSet: CharacterSet = {
            return CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "-._ "))
        }()
        
        func escape(_ str: String) -> String {
            return str.addingPercentEncoding(withAllowedCharacters: queryUrlEncodeAllowedSet)!.replacingOccurrences(of: " ", with: "+")
        }
        
        var request = urlRequest.urlRequest!
        if (params == nil) {
            return (request, nil)
        }
        
        let method = request.httpMethod
        let paramInUrl = method == HTTPMethod.get.rawValue || method == HTTPMethod.head.rawValue || method == HTTPMethod.delete.rawValue
        if (paramInUrl) {
            var url = URLComponents(url: request.url!, resolvingAgainstBaseURL: false)!
            url.queryItems = params!.map { k, v -> URLQueryItem in
                return URLQueryItem(name: k, value: "\(v)")
            }
        } else {
            request.addValue("application/x-www-form-urlencoded; encoding=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = params!.map { k, v -> String in
                return escape(k) + "=" + escape(String(describing: v))
                }.joined(separator: "&").data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        return (request, nil)
    }
    
    internal class StatelessCookieStorage: HTTPCookieStorage {
        override func cookies(for URL: URL) -> [HTTPCookie]? {
            return nil
        }
        
        override func setCookie(_ cookie: HTTPCookie) {
            // No-op
        }
        
        override func setCookies(_ cookies: [HTTPCookie], for URL: URL?, mainDocumentURL: URL?) {
            // No-op
        }
        
        override func storeCookies(_ cookies: [HTTPCookie], for task: URLSessionTask) {
            // No-op
        }
    }
    
}

enum RestError: Error {
    case networkError(err: NSError?)
    case requestError(statusCode: Int)
}

extension HTTPURLResponse {
    var ok: Bool {
        get {
            return statusCode >= 200 && statusCode < 300
        }
    }
}
