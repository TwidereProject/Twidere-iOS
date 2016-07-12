//
//  DefaultsKeys.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyUserDefaults

extension DefaultsKeys {
    static let apiUrlFormat = DefaultsKey<String?>("apiUrlFormat")
    static let authType = DefaultsKey<CustomAPIConfig.AuthType?>("authType")
    static let sameOAuthSigningUrl = DefaultsKey<Bool?>("sameOAuthSigningUrl")
    static let noVersionSuffix = DefaultsKey<Bool?>("noVersionSuffix")
    static let consumerKey = DefaultsKey<String?>("consumerKey")
    static let consumerSecret = DefaultsKey<String?>("consumerSecret")
}


extension NSUserDefaults {
    subscript(key: DefaultsKey<CustomAPIConfig.AuthType?>) -> CustomAPIConfig.AuthType? {
        get { return unarchive(key) }
        set { archive(key, newValue) }
    }
}