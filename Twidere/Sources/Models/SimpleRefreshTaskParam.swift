//
//  SimpleRefreshTaskParam.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/6.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import TwidereCore

class SimpleRefreshTaskParam: RefreshTaskParam {
    var accounts: [AccountDetails]
    
    var maxIds: [String?]? = nil
    
    var sinceIds: [String?]? = nil
    
    var maxSortIds: [Int64]? = nil
    
    var sinceSortIds: [Int64]? = nil
    
    var isLoadingMore: Bool = false
    
    init(accounts: [AccountDetails]) {
        self.accounts = accounts
    }
}
