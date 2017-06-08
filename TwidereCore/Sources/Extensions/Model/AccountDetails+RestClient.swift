//
//  AccountExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import RestClient
import RestCommons

public extension AccountDetails {

    public func getService<T:RestAPIProtocol>(endpointConfig: EndpointConfig, type: T.Type) -> T {
        return credentials.getService(accountType: self.type, endpointConfig: endpointConfig, type: type)
    }

}


public extension AccountDetails.Credentials {

    public func getService<T:RestAPIProtocol>(accountType: AccountDetails.AccountType!, endpointConfig: EndpointConfig, type: T.Type) -> T {
        let endpoint = getEndpoint(endpointConfig: endpointConfig)
        let auth = getAuthorization()
        return endpoint.getService(auth: auth, type: type)
    }

    public func getEndpoint(endpointConfig: EndpointConfig) -> Endpoint {
        let apiUrlFormat = api_url_format ?? defaultApiUrlFormat
        let noVersionSuffix = self.no_version_suffix
        let domain = endpointConfig.domain
        let versionSuffix = noVersionSuffix ? nil : endpointConfig.versionSuffix

        let endpointUrl = Endpoint.getApiUrl(apiUrlFormat, domain: domain, appendPath: versionSuffix)
        if let oauth = self as? OAuthCredentials {
            let signEndpointUrl: String
            if (oauth.same_oauth_signing_url) {
                signEndpointUrl = endpointUrl
            } else {
                signEndpointUrl = Endpoint.getApiUrl(defaultApiUrlFormat, domain: domain, appendPath: versionSuffix)
            }
            return OAuthEndpoint(base: endpointUrl, signingBase: signEndpointUrl)
        }
        return Endpoint(base: endpointUrl)
    }

    public func getAuthorization() -> Authorization! {
        switch self {
        case let typed as OAuthCredentials:
            let token = OAuthToken(typed.access_token, typed.access_token_secret)
            return OAuthAuthorization(typed.consumer_key, typed.consumer_secret, oauthToken: token)
        case let typed as BasicCredentials:
            return BasicAuthorization(username: typed.username, password: typed.password)
        case let typed as OAuth2Credentials:
            return OAuth2Authorization(accessToken: typed.access_token)
        case is EmptyCredentials:
            return EmptyAuthorization()
        default:
            return nil
        }
    }
}

extension Endpoint {

    static func getApiUrl(_ format: String, domain: String?, appendPath: String?) -> String {
        let urlBase = getApiBaseUrl(format, domain: domain)
        return Endpoint.construct(urlBase, path: appendPath ?? "")
    }

    static func getApiBaseUrl(_ format: String, domain: String?) -> String {
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

    static func substituteLegacyApiBaseUrl(_ format: String, domain: String?) -> String {
        return format
    }
}


public struct EndpointConfig {
    public var domain: String?
    public var versionSuffix: String?

    public static let twitter = EndpointConfig(domain: "api", versionSuffix: "1.1")
    public static let fanfou = EndpointConfig(domain: nil, versionSuffix: nil)
    public static let mastodon = EndpointConfig(domain: nil, versionSuffix: nil)
}

