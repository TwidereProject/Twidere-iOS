//
//  Freddy+Optional.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension JSON {
    public func decode<Decoded: JSONDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self, or: Decoded? = nil) throws -> Decoded? {
        guard let decoded: Decoded = try? decode(at: path) else {
            return or
        }
        return decoded
    }
    
    public func decodedArray<Decoded: JSONDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self, or: [Decoded]? = nil) throws -> [Decoded]? {
        guard let decoded: [Decoded] = try? decodedArray(at: path) else {
            return or
        }
        return decoded
    }
}

extension JSON {

    public func decode<Decoded: JSONStaticDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self, or: Decoded? = nil) throws -> Decoded? {
        guard let decoded: Decoded = try? decode(at: path) else {
            return or
        }
        return decoded
    }
    
    public func decodedArray<Decoded: JSONStaticDecodable>(at path: JSONPathType, type: Decoded.Type = Decoded.self, or: [Decoded]? = nil) throws -> [Decoded]? {
        guard let decoded: [Decoded] = try? decodedArray(at: path) else {
            return or
        }
        return decoded
    }
}
