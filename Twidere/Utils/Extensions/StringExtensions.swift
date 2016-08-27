//
//  StringExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension String.UnicodeScalarView {
    func utf16Count(range: Range<String.UnicodeScalarView.Index>) -> Int {
        var count = 0
        for scalar in self[range] {
            UTF16.encode(scalar, output: { unit in
                count+=1
            })
        }
        return count
    }
    
    func utf16Count() -> Int {
        var count = 0
        for scalar in self {
            UTF16.encode(scalar, output: { unit in
                count+=1
            })
        }
        return count
    }
}