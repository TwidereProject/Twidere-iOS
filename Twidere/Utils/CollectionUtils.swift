//
//  CollectionUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

/**
 From http://stackoverflow.com/a/25739498/859190
 */
func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
