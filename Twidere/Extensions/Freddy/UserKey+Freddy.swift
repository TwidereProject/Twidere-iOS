//
//  UserKey+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension UserKey: JSONDecodable {
    init(json: JSON) throws {
        guard case let .string(string) = json else {
            throw JSON.Error.valueNotConvertible(value: json, to: UserKey.self)
        }
        self = UserKey(rawValue: string)
    }
}

extension UserKey: JSONEncodable {
    func toJSON() -> JSON {
        return .string(string)
    }
}
