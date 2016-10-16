//
//  Date+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Freddy

extension Date: JSONDecodable {
    public init(json: JSON) throws {
        guard case let .string(string) = json, let date = Date(iso8601String: string) else {
            throw JSON.Error.valueNotConvertible(value: json, to: Date.self)
        }
        self = date
    }
}

extension Date: JSONEncodable {
    
    public func toJSON() -> JSON {
        return .string(iso8601String)
    }
    
}

extension JSON {
    public func getDate(at path: JSONPathType) throws -> Date {
        let json: JSON = try decode(at: path)
        return try Date(json: json)
    }
}

extension Int64: JSONDecodable {
    
    public init(json: JSON) throws {
        switch json {
        case let .double(double):
            self = Int64(double)
        case let .int(int):
            self = Int64(int)
        default:
            throw JSON.Error.valueNotConvertible(value: json, to: Int64.self)
        }
    }
}

extension Int64: JSONEncodable {
    private static let max32: Int64 = Int64(Int.max)
    
    public func toJSON() -> JSON {
        if (self > Int64.max32) {
            return .double(Double(self))
        }
        return .int(Int(self))
    }
}

extension JSON {
    public func getInt64(at path: JSONPathType) throws -> Int64 {
        let json: JSON = try decode(at: path)
        return try Int64(json: json)
    }
}
