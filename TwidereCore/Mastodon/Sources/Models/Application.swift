//
//  Application.swift
//  Mastodon
//
//  Created by Mariotaku Lee on 2017/6/8.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import Foundation

// sourcery: jsonParse
public class Application {

    // sourcery:jsonField=name
    var name: String!

    // sourcery:jsonField=website
    var website: String!

    required public init() {
        
    }
}
