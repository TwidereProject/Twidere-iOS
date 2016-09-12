//
//  UserKey+MsgPack.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import MessagePack_swift

extension MessagePackValue {
    init(_ value: NSDate) {
        self = .Double(value.timeIntervalSince1970)
    }
    
    var nsDateValue: NSDate? {
        switch self {
        case let .Double(value):
            return NSDate(timeIntervalSince1970: value)
        default:
            return nil
        }
    }
}
