//
//  AccountInner+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Freddy

extension Account.AccountType: JSONDecodable {
    
    public init(json: JSON) throws {
        guard case let .string(string) = json else {
            throw JSON.Error.valueNotConvertible(value: json, to: Account.AccountType.self)
        }
        guard let type = Account.AccountType(rawValue: string) else {
            throw JSON.Error.valueNotConvertible(value: json, to: Account.AccountType.self)
        }
        self = type
    }
}

extension Account.AccountType: JSONEncodable {
    func toJSON() -> JSON {
        return .string(rawValue)
    }
}
