//
//  Authorization.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import Foundation
import CryptoSwift
import Security
import Alamofire

protocol Authorization {
    var hasAuthorization: Bool { get }
    func getHeader(_ method: String, endpoint: Endpoint, path: String, queries: [String: String?]?, forms: [String: Any]?, encoding: URLEncoding) -> String!
}

class EmptyAuthorization: Authorization {
    
    var hasAuthorization: Bool = false
    
    func getHeader(_ method: String, endpoint: Endpoint, path: String, queries: [String : String?]?, forms: [String : Any]?, encoding: URLEncoding) -> String! {
        return nil
    }
}

//
// HTTP Basic Authorization
// Base64 encoded username and password
//
class BasicAuthorization: Authorization {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    var hasAuthorization: Bool = true
    
    func getHeader(_ method: String, endpoint: Endpoint, path: String, queries: [String : String?]?, forms: [String : Any]?, encoding: URLEncoding) -> String! {
        return "\(username):\(password)".utf8.map({$0}).toBase64()
    }
    
}

//
// OAuth 1.0a Authorization
// Based on Twidere for Android implementation
//
class OAuthAuthorization: Authorization {
    
    let oauthUrlEncodeAllowedSet: CharacterSet = {
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: "-._~")
        return allowed as CharacterSet
    }()
    
    let charsetEncoding = "UTF-8"
    let oauthSignatureMethod = "HMAC-SHA1"
    let oauthVersion = "1.0"
    let consumerKey: String
    let consumerSecret: String
    let oauthToken: OAuthToken?
    
    init(_ consumerKey: String, _ consumerSecret: String, oauthToken: OAuthToken? = nil) {
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.oauthToken = oauthToken
    }
    
    var hasAuthorization: Bool = true
    
    func getHeader(_ method: String, endpoint: Endpoint, path: String, queries: [String: String?]?, forms: [String: Any]?, encoding: URLEncoding) -> String! {
        let oauthEndpoint = endpoint as! OAuthEndpoint
        let signingUrl = oauthEndpoint.constructSigningUrl(path, queries: queries)
        let oauthParams = generateOAuthParams(method, url: signingUrl, oauthToken: oauthToken, queries: queries, forms: forms, encoding: encoding)
        return "OAuth " + oauthParams.map({ (k, v) -> String in
            return "\(k)=\"\(v)\""
        }).joined(separator: ", ")
    }
    
    fileprivate func generateOAuthParams(_ method: String, url: String, oauthToken: OAuthToken?, queries: [String: String?]?, forms: [String: Any]?, encoding: URLEncoding) -> [(String, String)] {
        let oauthNonce = generateOAuthNonce()
        let timestamp =  UInt64(Date().timeIntervalSince1970)
        let oauthSignature = generateOAuthSignature(method, url: url, oauthNonce: oauthNonce, timestamp: timestamp, oauthToken: oauthToken, queries: queries, forms: forms, encoding: encoding)
        var encodeParams: [(String, String)] = [
            ("oauth_consumer_key", consumerKey),
            ("oauth_nonce", oauthNonce),
            ("oauth_signature", escape(oauthSignature)),
            ("oauth_signature_method", oauthSignatureMethod),
            ("oauth_timestamp", String(timestamp)),
            ("oauth_version", oauthVersion)
        ]
        if (oauthToken != nil) {
            encodeParams.append(("oauth_token", oauthToken!.oauthToken))
        }
        encodeParams.sort { (l, r) -> Bool in
            return l.0 < r.0
        }
        return encodeParams
    }
    
    fileprivate func generateOAuthSignature(_ method: String, url: String, oauthNonce: String, timestamp: UInt64, oauthToken: OAuthToken?, queries: [String: String?]?, forms: [String: Any]?, encoding: URLEncoding) -> String {
        var oauthParams: [String] = [
            escape("oauth_consumer_key", consumerKey),
            escape("oauth_nonce", oauthNonce),
            escape("oauth_signature_method", oauthSignatureMethod),
            escape("oauth_timestamp", String(timestamp)),
            escape("oauth_version", oauthVersion)
        ]
        if let token = oauthToken {
            oauthParams.append(escape("oauth_token", token.oauthToken))
        }
        queries?.forEach { (k, v) in
            if (v != nil) {
                for (ek, ev) in encoding.queryComponents(fromKey: k, value: v!) {
                    oauthParams.append("\(ek)=\(ev)")
                }
            } else {
                oauthParams.append("\(encoding.escape(k))")
            }
        }
        forms?.forEach { (k, v) in
            for (ek, ev) in encoding.queryComponents(fromKey: k, value: v) {
                oauthParams.append("\(ek)=\(ev)")
            }
        }
        // Sort params
        oauthParams.sort { (l, r) -> Bool in
            return l < r
        }
        let paramsString = oauthParams.joined(separator: "&")
        var signingKey: String = escape(consumerSecret) + "&"
        if let oauthToken = oauthToken {
            signingKey += escape(oauthToken.oauthTokenSecret)
        }
        let signingKeyBytes = signingKey.utf8.map{$0}
        
        let urlNoQuery: String
        if let lowerBound = url.range(of: "?")?.lowerBound {
            urlNoQuery = url.substring(to: lowerBound)
        } else {
            urlNoQuery = url
        }
        let baseString = escape(method) + "&" + escape(urlNoQuery) + "&" + escape(paramsString)
        let baseBytes = baseString.utf8.map{$0}
        let hmac: [UInt8] = try! HMAC(key: signingKeyBytes, variant: .sha1).authenticate(baseBytes)
        return hmac.toBase64()!
    }
    
    fileprivate func generateOAuthNonce() -> String {
        let bytesCount = 16 // number of bytes
        var randomBytes = [UInt8](repeating: 0, count: bytesCount) // array to hold randoms bytes
        
        // Gen random bytes
        _ = SecRandomCopyBytes(kSecRandomDefault, bytesCount, &randomBytes)
        
        return randomBytes.toHexString()
    }
    
    fileprivate func escape(_ str: String) -> String {
        return str.addingPercentEncoding(withAllowedCharacters: oauthUrlEncodeAllowedSet)!
    }
    
    fileprivate func escape(_ key: String, _ value: String) -> String {
        return escape(key) + "=" + escape(value)
    }
    
}

class OAuth2Authorization: Authorization {
    
    var accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    private(set) var hasAuthorization: Bool = true
    
    func getHeader(_ method: String, endpoint: Endpoint, path: String, queries: [String : String?]?, forms: [String : Any]?, encoding: URLEncoding) -> String! {
        return "Baerer \(accessToken)"
    }
}

class OAuthToken {
    let oauthToken: String
    let oauthTokenSecret: String
    var screenName: String? = nil
    var userId: String? = nil
    
    init(_ oauthToken: String, _ oauthTokenSecret: String) {
        self.oauthToken = oauthToken
        self.oauthTokenSecret = oauthTokenSecret
    }
    
}
