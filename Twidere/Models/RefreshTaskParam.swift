//
//  RefreshTaskParam.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class RefreshTaskParam {
    var accounts: [Account]
    
    var maxIds: [String?]? = nil
    
    var sinceIds: [String?]? = nil
    
    var maxSortIds: [Int64]? = nil
    
    var sinceSortIds: [Int64]? = nil
    
    var isLoadingMore: Bool = false
    
    init(accounts: [Account]) {
        self.accounts = accounts
    }
}
