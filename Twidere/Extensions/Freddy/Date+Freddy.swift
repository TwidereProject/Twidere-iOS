//
//  Date+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension Date: JSONDecodable {
    
    fileprivate static let jsonDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    public init(json: JSON) throws {
        guard case let .string(string) = json else {
            throw JSON.Error.valueNotConvertible(value: json, to: Date.self)
        }
        guard let date = Date.jsonDateFormatter.date(from: string) else {
            throw JSON.Error.valueNotConvertible(value: json, to: Date.self)
        }
        self = date
    }
}

extension Date: JSONEncodable {
    public func toJSON() -> JSON {
        return .string(Date.jsonDateFormatter.string(from: self))
    }
}
