//
//  ActivityInner+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension Activity.Action: JSONDecodable {
    
    public init(json: JSON) throws {
        guard case let .string(string) = json else {
            throw JSON.Error.valueNotConvertible(value: json, to: Activity.Action.self)
        }
        guard let type = Activity.Action(rawValue: string) else {
            throw JSON.Error.valueNotConvertible(value: json, to: Activity.Action.self)
        }
        self = type
    }
}

extension Activity.Action: JSONEncodable {
    func toJSON() -> JSON {
        return .string(rawValue)
    }
}
