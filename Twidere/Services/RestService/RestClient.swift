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
            let completionHandler: (DataResponse<T>) -> Void = { response in
                switch response.result {
                case .success(let value):
                    fullfill(value)
                case .failure(let error):
                    reject(error)
                }
            }
            if let params = params, params.contains(where: { $0.1 is Data }) {
                //finalHeaders["Content-Type"] = multipart.contentType
                let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, auth: finalAuth)
                Alamofire.upload(
                    multipartFormData: { multipart in
                        for (k, v) in params {
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
                let encoding = URLEncoding.methodDependent
                let finalHeaders = constructHeaders(method, path: path, headers: headers, queries: queries, forms: params, auth: finalAuth, encoding: encoding)
                let request = Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: finalHeaders)
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
    
    fileprivate func constructHeaders(_ method: HTTPMethod, path: String, headers: [String: String]? = nil, queries: [String: String]? = nil, forms: [String: Any]? = nil, auth: Authorization?, encoding: URLEncoding? = nil) -> [String: String] {
        var mergedHeaders = [String: String]()
        if let headers = headers {
            for (k, v) in headers {
                mergedHeaders[k] = v
            }
        }
        if let auth = auth, let encoding = encoding, auth.hasAuthorization {
            mergedHeaders["Authorization"] = auth.getHeader(method.rawValue, endpoint: endpoint, path: path, queries: queries, forms: forms, encoding: encoding)
        }
        if let userAgent = userAgent {
            mergedHeaders["User-Agent"] = userAgent
        }
        return mergedHeaders
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
    
    // MARK: -
    
    /// Creates a url-encoded query string to be set as or appended to any existing URL query string or set as the HTTP
    /// body of the URL request. Whether the query string is set or appended to any existing URL query string or set as
    /// the HTTP body depends on the destination of the encoding.
    ///
    /// The `Content-Type` HTTP header field of an encoded request with HTTP body is set to
    /// `application/x-www-form-urlencoded; charset=utf-8`. Since there is no published specification for how to encode
    /// collection types, the convention of appending `[]` to the key for array values (`foo[]=1&foo[]=2`), and appending
    /// the key surrounded by square brackets for nested dictionary values (`foo[bar]=baz`).
    struct TwidereURLEncoding: ParameterEncoding {
        
        // MARK: Helper Types
        
        /// Defines whether the url-encoded query string is applied to the existing query string or HTTP body of the
        /// resulting URL request.
        ///
        /// - methodDependent: Applies encoded query string result to existing query string for `GET`, `HEAD` and `DELETE`
        ///                    requests and sets as the HTTP body for requests with any other HTTP method.
        /// - queryString:     Sets or appends encoded query string result to existing query string.
        /// - httpBody:        Sets encoded query string result as the HTTP body of the URL request.
        public enum Destination {
            case methodDependent, queryString, httpBody
        }
        
        // MARK: Properties
        
        /// Returns a default `URLEncoding` instance.
        public static var `default`: URLEncoding { return URLEncoding() }
        
        /// Returns a `URLEncoding` instance with a `.methodDependent` destination.
        public static var methodDependent: URLEncoding { return URLEncoding() }
        
        /// Returns a `URLEncoding` instance with a `.queryString` destination.
        public static var queryString: URLEncoding { return URLEncoding(destination: .queryString) }
        
        /// Returns a `URLEncoding` instance with an `.httpBody` destination.
        public static var httpBody: URLEncoding { return URLEncoding(destination: .httpBody) }
        
        /// The destination defining where the encoded query string is to be applied to the URL request.
        public let destination: Destination
        
        // MARK: Initialization
        
        /// Creates a `URLEncoding` instance using the specified destination.
        ///
        /// - parameter destination: The destination defining where the encoded query string is to be applied.
        ///
        /// - returns: The new `URLEncoding` instance.
        public init(destination: Destination = .methodDependent) {
            self.destination = destination
        }
        
        // MARK: Encoding
        
        /// Creates a URL request by encoding parameters and applying them onto an existing request.
        ///
        /// - parameter urlRequest: The request to have parameters applied.
        /// - parameter parameters: The parameters to apply.
        ///
        /// - throws: An `Error` if the encoding process encounters an error.
        ///
        /// - returns: The encoded request.
        public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
            var urlRequest = try urlRequest.asURLRequest()
            
            guard let parameters = parameters else { return urlRequest }
            
            if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"), encodesParametersInURL(with: method) {
                guard let url = urlRequest.url else {
                    throw AFError.parameterEncodingFailed(reason: .missingURL)
                }
                
                if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                    let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                    urlComponents.percentEncodedQuery = percentEncodedQuery
                    urlRequest.url = urlComponents.url
                }
            } else {
                if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                    urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
                }
                
                urlRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
            }
            
            return urlRequest
        }
        
        /// Creates percent-escaped, URL encoded query string components from the given key-value pair using recursion.
        ///
        /// - parameter key:   The key of the query component.
        /// - parameter value: The value of the query component.
        ///
        /// - returns: The percent-escaped, URL encoded query string components.
        public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
            var components: [(String, String)] = []
            
            if let dictionary = value as? [String: Any] {
                for (nestedKey, value) in dictionary {
                    components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
                }
            } else if let array = value as? [Any] {
                for value in array {
                    components += queryComponents(fromKey: "\(key)[]", value: value)
                }
            } else if let value = value as? NSNumber {
                if value.isBool {
                    components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
                } else {
                    components.append((escape(key), escape("\(value)")))
                }
            } else if let bool = value as? Bool {
                components.append((escape(key), escape((bool ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
            
            return components
        }
        
        /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
        ///
        /// RFC 3986 states that the following characters are "reserved" characters.
        ///
        /// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
        /// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
        ///
        /// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
        /// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
        /// should be percent-escaped in the query string.
        ///
        /// - parameter string: The string to be percent-escaped.
        ///
        /// - returns: The percent-escaped string.
        public func escape(_ string: String) -> String {
            let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
            let subDelimitersToEncode = "!$&'()*+,;="
            
            var allowedCharacterSet = CharacterSet.urlQueryAllowed
            allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
            
            return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        }
        
        private func query(_ parameters: [String: Any]) -> String {
            var components: [(String, String)] = []
            
            for key in parameters.keys.sorted(by: <) {
                let value = parameters[key]!
                components += queryComponents(fromKey: key, value: value)
            }
            
            return components.map { "\($0)=\($1)" }.joined(separator: "&")
        }
        
        private func encodesParametersInURL(with method: HTTPMethod) -> Bool {
            switch destination {
            case .queryString:
                return true
            case .httpBody:
                return false
            default:
                break
            }
            
            switch method {
            case .get, .head, .delete:
                return true
            default:
                return false
            }
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

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
