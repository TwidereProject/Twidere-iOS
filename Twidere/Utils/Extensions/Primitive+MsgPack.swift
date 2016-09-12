//
// Created by Mariotaku Lee on 16/9/12.
// Copyright (c) 2016 Mariotaku Dev. All rights reserved.
//

import Foundation

extension MessagePackValue {
    public var int64Value: Int64? {
        return self.integerValue
    }

    public var intValue: Int? {
        return self.integerValue
    }
}