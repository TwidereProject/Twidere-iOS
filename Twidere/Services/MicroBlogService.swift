//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Alamofire

class MicroBlogService {
    
    let endpoint: Endpoint
    let auth: Authorization
    
    init(endpoint: Endpoint, auth: Authorization) {
        self.endpoint = endpoint
        self.auth = auth
    }
    
    func verifyCredentials() {
        makeRequest(.GET, path: "/account/verify_credentials.json")
    }
    
    private func makeRequest(method: Method, path: String, queries:[String: String]? = nil, parameters: [String: AnyObject]? = nil) {
        let url = constructUrl(path, queries: queries)
        let headers = constructHeaders(method, path: path, queries: queries, parameters: parameters)
        Alamofire.request(method, url, parameters: parameters, headers: headers)
    }
    
    private func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        return endpoint.constructUrl(path, queries: queries)
    }
    
    private func constructHeaders(method: Method, path: String, queries: [String: String]? = nil, parameters: [String: AnyObject]? = nil) -> [String: String] {
        return [String: String]()
    }
}


class Endpoint {
    
    let base: String
    
    init(base: String) {
        self.base = base
    }
    
    func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        return "\(base)\(path)"
    }
}

class OAuthEndpoint: Endpoint {
    
    let signingBase: String
    
    init(base: String, signingBase: String) {
        self.signingBase = signingBase
        super.init(base: base)
    }
    
    
    func constructSigningUrl(path: String, queries: [String: String]? = nil) -> String {
        return "\(signingBase)\(path)"
    }
}

protocol Authorization {
    func hasAuthorization() -> Bool
    func getAuthorizationHeader(method: Method, endpoint: Endpoint, path: String, queries: [String: String]?, parameters: [String: AnyObject]?) -> String?
}

class OAuthAuthorization: Authorization {
    func hasAuthorization() -> Bool {
        return false
    }
    
    func getAuthorizationHeader(method: Method, endpoint: Endpoint, path: String, queries: [String: String]? = nil, parameters: [String: AnyObject]? = nil) -> String? {
        return nil
    }
}