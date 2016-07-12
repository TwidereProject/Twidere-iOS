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
    
    static let apiVersion = "1.1"
    
    var apiUrlFormat: String = ServiceConstants.defaultApiUrlFormat
    var authType: AuthType = .OAuth
    var sameOAuthSigningUrl: Bool = true
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
    
    func createEndpoint(domain: String?) -> Endpoint {
        return createEndpoint(domain, noVersionSuffix: noVersionSuffix)
    }
    
    func createEndpoint(domain: String?, noVersionSuffix: Bool, fixUrl: (String -> String)? = nil) -> Endpoint {
        let base: String
        if (noVersionSuffix) {
            base = getApiBaseUrl(apiUrlFormat, domain: domain)
        } else {
            base = Endpoint.construct(getApiBaseUrl(apiUrlFormat, domain: domain), path: "/1.1/")
        }
        switch authType {
        case .OAuth, .xAuth:
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
        if (domain != nil) {
            return compiled.replaceAll(in: format, with: "$1\(domain!)$2")
        } else {
            return compiled.replaceAll(in: format, with: "")
        }
    }
    
    func substituteLegacyApiBaseUrl(format: String, domain: String?) -> String {
        return format
    }
    
    func loadDefaults()  {
        apiUrlFormat = Defaults[.apiUrlFormat] ?? ServiceConstants.defaultApiUrlFormat
        authType = Defaults[.authType] ?? .OAuth
        sameOAuthSigningUrl = Defaults[.sameOAuthSigningUrl] ?? true
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

enum AccountType: String {
    case Twitter, Fanfou, StatusNet
}