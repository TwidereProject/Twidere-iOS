//
//  UserKey+MsgPack.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import MessagePack_swift

extension MessagePackValue {
    init(_ value: UserKey) {
        self = .String(value.string)
    }
    
    var userKeyValue: UserKey? {
        switch self {
        case let .String(string):
            return UserKey(rawValue: string)
        default:
            return nil
        }
    }
}
