//
//  DefaultsKeys.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyUserDefaults
import TwidereCore

extension DefaultsKeys {
    static let apiUrlFormat = DefaultsKey<String?>("apiUrlFormat")
    static let authType = DefaultsKey<AccountDetails.CredentialsType?>("authType")
    static let sameOAuthSigningUrl = DefaultsKey<Bool?>("sameOAuthSigningUrl")
    static let noVersionSuffix = DefaultsKey<Bool?>("noVersionSuffix")
    static let consumerKey = DefaultsKey<String?>("consumerKey")
    static let consumerSecret = DefaultsKey<String?>("consumerSecret")
    
    static let attachLocation = DefaultsKey<Bool>("attachLocation")
    static let attachPreciseLocation = DefaultsKey<Bool>("attachPreciseLocation")
    
    static let defaultAccount = DefaultsKey<String?>("defaultAccount")
    
    static let loadItemLimit = DefaultsKey<Int?>("loadItemLimit")
}


extension UserDefaults {
    subscript(key: DefaultsKey<AccountDetails.CredentialsType?>) -> AccountDetails.CredentialsType? {
        get { return self.unarchive(key) }
        set { self.archive(key, newValue) }
    }
}
