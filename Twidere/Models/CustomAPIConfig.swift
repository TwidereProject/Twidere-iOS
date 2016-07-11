//
//  CustomAPIConfig.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Regex
import SwiftyUserDefaults

class CustomAPIConfig {
    
    let apiVersion = "1.1"
    
    var apiUrlFormat: String = ServiceConstants.defaultApiUrlFormat
    var authType: AuthType = .OAuth
    var sameOAuthUrl: Bool = true
    var noVersionSuffix: Bool = false
    var consumerKey: String = ServiceConstants.defaultTwitterConsumerKey
    var consumerSecret: String = ServiceConstants.defaultTwitterConsumerSecret
    
    var valid: Bool {
        get {
            // Must have a valid API URL format
            if (apiUrlFormat.isEmpty) {
                return false
            }
            switch authType {
            case .OAuth, .xAuth:
                return !consumerKey.isEmpty && !consumerSecret.isEmpty
            default:
                return true
            }
        }
    }
    
    func createEndpoint(domain: String?, noVersionSuffix: Bool) -> Endpoint {
        let base: String
        if (noVersionSuffix) {
            base = getApiBaseUrl(apiUrlFormat, domain: domain)
        } else {
            base = Endpoint.construct(getApiBaseUrl(apiUrlFormat, domain: domain), path: "/1.1/")
        }
        switch authType {
        case .OAuth, .xAuth:
            let signingBase: String
            if (sameOAuthUrl) {
                signingBase = base
            } else if (noVersionSuffix) {
                signingBase = getApiBaseUrl("https://[DOMAIN.]twitter.com/", domain: domain)
            } else {
                signingBase = Endpoint.construct(getApiBaseUrl("https://[DOMAIN.]twitter.com/", domain: domain), path: "/1.1/")
            }
            return OAuthEndpoint(base: base, signingBase: signingBase)
        default:
            return Endpoint(base: base)
        }
    }
    
    func getApiUrl(format: String, domain: String?, appendPath: String?) -> String {
        let urlBase = getApiBaseUrl(format, domain: domain)
        return Endpoint.construct(urlBase, path: appendPath ?? "")
    }
    
    func getApiBaseUrl(format: String, domain: String?) -> String {
        let compiled = "\\[(\\.?)DOMAIN(\\.?)\\]".r!
        if (compiled.findFirst(in: format) == nil) {
            // For backward compatibility
            let legacyFormat = substituteLegacyApiBaseUrl(format, domain: domain)
            if (!legacyFormat.hasSuffix("/1.1") && !legacyFormat.hasSuffix("/1.1/")) {
                return legacyFormat
            }
            return legacyFormat
        }
        return compiled.replaceAll(in: format, using: { (match) -> String? in
            if (domain == nil) {
                return ""
            }
            let g1 = match.group(at: 0) ?? "", g2 = match.group(at: 1) ?? ""
            return g1 + domain! + g2
        })
    }
    
    func substituteLegacyApiBaseUrl(format: String, domain: String?) -> String {
        return format
    }
    
    func loadDefaults()  {
        apiUrlFormat = Defaults[.apiUrlFormat] ?? ServiceConstants.defaultApiUrlFormat
        authType = Defaults[.authType] ?? .OAuth
        sameOAuthUrl = Defaults[.sameOAuthUrl] ?? true
        noVersionSuffix = Defaults[.noVersionSuffix] ?? false
        consumerKey = Defaults[.consumerKey] ?? ServiceConstants.defaultTwitterConsumerKey
        consumerSecret = Defaults[.consumerSecret] ?? ServiceConstants.defaultTwitterConsumerSecret
    }
    
    enum AuthType: String {
        case OAuth, xAuth, Basic, TwipO
        
        var isOAuthType: Bool {
            get {
                return self == .OAuth || self == .xAuth
            }
        }
        
        var usePassword: Bool {
            get {
                return self == .xAuth || self == .Basic
            }
        }
    }
}
