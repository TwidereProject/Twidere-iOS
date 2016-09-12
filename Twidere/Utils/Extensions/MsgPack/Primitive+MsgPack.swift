//
// Created by Mariotaku Lee on 16/9/12.
// Copyright (c) 2016 Mariotaku Dev. All rights reserved.
//

import Foundation
import MessagePack_swift

extension MessagePackValue {
    public var int64Value: Int64? {
        return self.integerValue
    }

    public var intValue: Swift.Int? {
        guard let value = self.integerValue else {
            return nil
        }
        return Swift.Int(value)
    }
}