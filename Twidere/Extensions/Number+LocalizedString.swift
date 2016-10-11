//
//  Number+LocalizedString.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Int64 {
    var shortLocalizedString: String {
        return NumberFormatter.localizedString(from: NSNumber(value: self), number: .decimal)
    }
}
