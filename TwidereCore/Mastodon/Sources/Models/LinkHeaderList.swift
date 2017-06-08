//
//  LinkHeaderArray.swift
//  Mastodon
//
//  Created by Mariotaku Lee on 2017/6/7.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import Foundation

public struct LinkHeaderList<T> {
    public let data: [T]
    private(set) public var linkParts: [String: String]
    
    public init(data: [T]) {
        self.data = data
        self.linkParts = [:]
    }
}
