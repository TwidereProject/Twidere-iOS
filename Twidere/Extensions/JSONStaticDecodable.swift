//
//  JSONStaticDecodable.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

/// A protocol to provide functionality for creating a model object with a `JSON`
/// value. Useful for extension for class. Only works for `final` classes
public protocol JSONStaticDecodable {
    associatedtype DecodableType
    
    static func fromJSON(json: JSON) throws -> DecodableType
}

func fromJSON<T: JSONStaticDecodable>(json: JSON) throws -> T {
    return try T.fromJSON(json: json) as! T
}
