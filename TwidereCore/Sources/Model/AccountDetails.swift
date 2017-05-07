//
//  AccountDetails.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/4.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PMJackson
import PMJSON

public class AccountDetails {
    
    public var key: UserKey!
    
    public var type: AccountType = .twitter
    
    public var credentialsType: CredentialsType = .oauth
    
    public var user: PersistableUser!
    
    public var color: Int = 0
    
    public var position: Int = 0
    
    public var activated: Bool = false
    
    var _credentialsJson: String!
    var _credentials: Credentials!
    
    var _extrasJson: String!
    var _extras: Extras!
    
    public var credentials: Credentials! {
        get {
            if (_credentials != nil) {
                return _credentials
            }
            guard let json = _credentialsJson else {
                return nil
            }
            switch (credentialsType) {
            case .oauth, .xauth:
                _credentials = OAuthCredentialsJsonMapper.singleton.parse(json: json)
            case .oauth2:
                _credentials = OAuth2CredentialsJsonMapper.singleton.parse(json: json)
            case .basic:
                _credentials = BasicCredentialsJsonMapper.singleton.parse(json: json)
            case .empty:
                _credentials = EmptyCredentialsJsonMapper.singleton.parse(json: json)
            }
            return _credentials
        }
        set {
            _credentials = newValue
        }
    }
    
    
    public enum AccountType: String {
        case twitter = "twitter", statusnet = "statusnet", fanfou = "fanfou", mastodon = "mastodon"
    }
    
    public enum CredentialsType: String {
        case oauth = "oauth", xauth = "xauth", basic = "basic", empty = "empty", oauth2 = "oauth2"
    }
    
    //sourcery: jsonParse
    public class Credentials {
        //sourcery: jsonField=api_url_format
        public var api_url_format: String!
        //sourcery: jsonField=no_version_suffix
        public var no_version_suffix: Bool = false
        
        required public init() {
            
        }
    }
    
    //sourcery: jsonParse
    public class Extras {
        
        required public init() {
            
        }
    }
}
