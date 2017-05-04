//
//  Number+LocalizedString.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension Int64 {
    private static let countUnits = ["", "K", "M", "B"]
    
    var shortLocalizedString: String {
        if (self < 1000) {
            return String(self)
        }
        var value: Double = Double(self)
        var index: Int = 0
        while index < Int64.countUnits.count {
            if (value < 1000) {
                break
            }
            value = value / 1000.0
            index += 1
        }
        let remainder = value.remainder(dividingBy: 1)
        if (value < 10 && remainder >= 0.049 && remainder < 0.5) {
            return String(format: "%.1f %@", locale: Locale.current, value, Int64.countUnits[index]);
        } else {
            return String(format: "%.0f %@", locale: Locale.current, value, Int64.countUnits[index]);
        }
    }
}
