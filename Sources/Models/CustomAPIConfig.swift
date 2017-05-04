//
//  CustomAPIConfig.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class CustomAPIConfig {
    
    static let apiVersion = "1.1"
    
    var apiUrlFormat: String = defaultApiUrlFormat
    var authType: Account.AuthType = defaultAuthType
    var sameOAuthSigningUrl: Bool = true
    var noVersionSuffix: Bool = false
    var consumerKey: String? = defaultTwitterConsumerKey
    var consumerSecret: String? = defaultTwitterConsumerSecret
    
    var valid: Bool {
        get {
            // Must have a valid API URL format
            if (apiUrlFormat.isEmpty) {
                return false
            }
            switch authType {
            case .oauth, .xAuth:
                return !(consumerKey?.isEmpty ?? true) && !(consumerSecret?.isEmpty ?? true)
            default:
                return true
            }
        }
    }
    
    func createEndpoint(_ domain: String?) -> Endpoint {
        return createEndpoint(domain, noVersionSuffix: noVersionSuffix)
    }
    
    func createEndpoint(_ domain: String?, noVersionSuffix: Bool, fixUrl: ((String) -> String)? = nil) -> Endpoint {
        let base: String
        if (noVersionSuffix) {
            base = getApiBaseUrl(apiUrlFormat, domain: domain)
        } else {
            base = Endpoint.construct(getApiBaseUrl(apiUrlFormat, domain: domain), path: "/1.1/")
        }
        switch authType {
        case .oauth, .xAuth:
            let signingBase: String
            if (sameOAuthSigningUrl) {
                signingBase = base
            } else if (noVersionSuffix) {
                signingBase = getApiBaseUrl("https://[DOMAIN.]twitter.com/", domain: domain)
            } else {
                signingBase = Endpoint.construct(getApiBaseUrl("https://[DOMAIN.]twitter.com/", domain: domain), path: "/1.1/")
            }
            return OAuthEndpoint(base: base, signingBase: signingBase, fixUrl: fixUrl)
        default:
            return Endpoint(base: base, fixUrl: fixUrl)
        }
    }
    
    func getApiUrl(_ format: String, domain: String?, appendPath: String?) -> String {
        let urlBase = getApiBaseUrl(format, domain: domain)
        return Endpoint.construct(urlBase, path: appendPath ?? "")
    }
    
    func getApiBaseUrl(_ format: String, domain: String?) -> String {
        let regex = try! NSRegularExpression(pattern: "\\[(\\.?)DOMAIN(\\.?)\\]", options: .caseInsensitive)
        if (regex.firstMatch(in: format, range: NSRange(0..<format.utf16.count)) == nil) {
            // For backward compatibility
            let legacyFormat = substituteLegacyApiBaseUrl(format, domain: domain)
            if (!legacyFormat.hasSuffix("/1.1") && !legacyFormat.hasSuffix("/1.1/")) {
                return legacyFormat
            }
            return legacyFormat
        }
        if (domain != nil) {
            return regex.stringByReplacingMatches(in: format, options: [], range: NSRange(0..<format.utf16.count), withTemplate: "$1\(domain!)$2")
        } else {
            return regex.stringByReplacingMatches(in: format, options: [], range: NSRange(0..<format.utf16.count), withTemplate: "")
        }
    }
    
    func substituteLegacyApiBaseUrl(_ format: String, domain: String?) -> String {
        return format
    }
    
    func loadDefaults()  {
        apiUrlFormat = Defaults[.apiUrlFormat] ?? defaultApiUrlFormat
        authType = Defaults[.authType] ?? .oauth
        sameOAuthSigningUrl = Defaults[.sameOAuthSigningUrl] ?? true
        noVersionSuffix = Defaults[.noVersionSuffix] ?? false
        consumerKey = Defaults[.consumerKey] ?? defaultTwitterConsumerKey
        consumerSecret = Defaults[.consumerSecret] ?? defaultTwitterConsumerSecret
    }

}
