//
//  Endpoint.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation


class Endpoint {
    
    typealias FixUrl = ((String) -> String)
    
    let base: String
    var fixUrl: FixUrl?
    
    init(base: String, fixUrl: FixUrl? = nil) {
        self.base = base
        self.fixUrl = fixUrl
    }
    
    func constructUrl(_ path: String, queries: [String: String]? = nil) -> String {
        let url = Endpoint.construct(base, path: path, queries: queries)
        if (fixUrl != nil) {
            return fixUrl!(url)
        }
        return url
    }
    
    static func construct(_ base: String, path: String, queries: [String: String]? = nil) -> String {
        var components = URLComponents(string: base)!
        var basePath = components.path ?? ""
        if (basePath.hasSuffix("/")) {
            basePath = basePath.substring(to: basePath.characters.index(basePath.endIndex, offsetBy: -1))
        }
        if (path.hasPrefix("/")) {
            components.path = "\(basePath)\(path)"
        } else {
            components.path = "\(basePath)/\(path)"
        }
        var queryItems = [URLQueryItem]()
        if (components.queryItems != nil) {
            queryItems.append(contentsOf: components.queryItems!)
        }
        queries?.forEach{ k, v in
            queryItems.append(URLQueryItem(name: k, value: v))
        }
        if (queryItems.isEmpty) {
            components.queryItems = nil
        } else {
            components.queryItems = queryItems
        }
        return components.string!
    }
    
    
}

class OAuthEndpoint: Endpoint {
    
    let signingBase: String
    
    override init(base: String, fixUrl: FixUrl? = nil) {
        self.signingBase = base
        super.init(base: base, fixUrl: fixUrl)
    }
    
    init(base: String, signingBase: String, fixUrl: FixUrl? = nil) {
        self.signingBase = signingBase
        super.init(base: base, fixUrl: fixUrl)
    }
    
    
    func constructSigningUrl(_ path: String, queries: [String: String]? = nil) -> String {
        let url = Endpoint.construct(signingBase, path: path, queries: queries)
        if (fixUrl != nil) {
            return fixUrl!(url)
        }
        return url
    }
}
