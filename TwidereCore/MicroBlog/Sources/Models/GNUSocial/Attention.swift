//
//  GNUSocialAttention.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

// sourcery: jsonParse
public class Attention {
    // sourcery: jsonField=fullname
    public var fullName: String!
    // sourcery: jsonField=id
    public var id: String!
    // sourcery: jsonField=ostatus_uri
    public var ostatusUri: String!
    // sourcery: jsonField=profileurl
    public var profileUrl: String!
    // sourcery: jsonField=screen_name
    public var screenName: String!
    
    required public init() {
        
    }
}
