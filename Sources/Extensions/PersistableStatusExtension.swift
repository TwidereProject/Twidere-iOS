//
//  PersistableStatusExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

extension PersistableStatus {
    
    func addFilterFlag(_ flag : PersistableStatus.FilterFlag) {
        filter_flags = filter_flags.union(flag)
    }
}
