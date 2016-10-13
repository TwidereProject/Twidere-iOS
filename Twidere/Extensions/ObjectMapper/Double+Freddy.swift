//
//  Double+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension Int64: JSONDecodable {
    
    /// An initializer to create an instance of `Int64` from a `JSON` value.
    /// - parameter json: An instance of `JSON`.
    /// - throws: The initializer will throw an instance of `JSON.Error` if
    ///           an instance of `Int64` cannot be created from the `JSON` value that was
    ///           passed to this initializer.
    public init(json: JSON) throws {
        switch json {
        case let .double(double):
            self = Int64(double)
        case let .int(int):
            self = Int64(int)
        default:
            throw JSON.Error.valueNotConvertible(value: json, to: Double.self)
        }
    }
    
}

extension Int64: JSONEncodable {
    public func toJSON() -> JSON {
        return .double(Double(self))
    }
}
