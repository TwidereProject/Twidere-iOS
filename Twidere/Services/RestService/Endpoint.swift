//
//  Endpoint.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation


class Endpoint {
    
    typealias FixUrl = (String -> String)
    
    let base: String
    var fixUrl: FixUrl?
    
    init(base: String, fixUrl: FixUrl? = nil) {
        self.base = base
        self.fixUrl = fixUrl
    }
    
    func constructUrl(path: String, queries: [String: String]? = nil) -> String {
        let url = Endpoint.construct(base, path: path, queries: queries)
        if (fixUrl != nil) {
            return fixUrl!(url)
        }
        return url
    }
    
    static func construct(base: String, path: String, queries: [String: String]? = nil) -> String {
        let fixedBase: String
        if (base.hasSuffix("/")) {
            fixedBase = base.substringToIndex(base.endIndex.advancedBy(-1))
        } else {
            fixedBase = base
        }
        let fixedPath: String
        if (path.hasPrefix("/")) {
            fixedPath = path.substringFromIndex(path.startIndex.advancedBy(1))
        } else {
            fixedPath = path
        }
        if (!(queries?.isEmpty ?? true)) {
            let queriesPart = queries!.map({ (s, v) -> String in
                return Endpoint.paramEncode(s, value: v)
            }).joinWithSeparator("&")
            return fixedBase + "/" + fixedPath + "?" + queriesPart
        }
        return fixedBase + "/" + fixedPath
    }
    
    static func urlEncode(str: String) -> String {
        return str.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
    }
    
    static func paramEncode(key: String, value: String) -> String {
        return urlEncode(key) + "=" + urlEncode(value)
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
    
    
    func constructSigningUrl(path: String, queries: [String: String]? = nil) -> String {
        let url = Endpoint.construct(signingBase, path: path, queries: queries)
        if (fixUrl != nil) {
            return fixUrl!(url)
        }
        return url
    }
}