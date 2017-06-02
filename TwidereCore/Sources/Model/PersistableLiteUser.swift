//
//  PersistableLiteUser.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//


//sourcery: jsonParse
public class PersistableLiteUser {
    
    // sourcery: jsonField=account_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    public var account_key: UserKey!
    
    // sourcery: jsonField=key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    public var key: UserKey!
    // sourcery: jsonField=name
    public var name: String!
    // sourcery: jsonField=screen_name
    public var screen_name: String!
    // sourcery: jsonField=profile_image_url
    public var profile_image_url: String!
    // sourcery: jsonField=is_following
    public var is_following: Bool = false
    
    required public init() {
        
    }
    
}
