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

extension JSON: JSONDecodable {
    public init(json: JSON) throws {
        self = json
    }
}

extension JSON {
    public func decode<Decoded: JSONStaticDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self) throws -> Decoded {
        let json: JSON = try decode(at: path)
        return try Decoded.fromJSON(json: json) as! Decoded
    }
    
    public func decodedArray<Decoded: JSONStaticDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self) throws -> [Decoded] {
        return try getArray(at: path).map { try Decoded.fromJSON(json: $0) as! Decoded }
    }
}
