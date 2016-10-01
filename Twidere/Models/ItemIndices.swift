//
//  ItemIndices.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class ItemIndices {
    
    private var data: [Int]
    
    init(_ count: Int) {
        data = [Int](repeating: 0, count: count)
    }
    
    func getItemCountIndex(position: Int) -> Int {
        var sum: Int = 0
        for idx in 0..<data.count {
            let count = data[idx]
            sum += count
            if (position < sum) {
                return idx
            }
        }
        return -1
    }
    
    func getItemStartPosition(index: Int) -> Int {
        return self.data[0..<index].reduce(0) { $0 + $1 }
    }
    
    subscript(index: Int) -> Int {
        get { return data[index] }
        set { data[index] = newValue }
    }
    
    var count: Int {
        return data.reduce(0) { $0 + $1 }
    }
}
