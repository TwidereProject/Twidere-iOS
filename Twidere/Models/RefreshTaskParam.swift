//
//  RefreshTaskParam.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

protocol RefreshTaskParam {
    
    var accounts: [Account] { get }
    
    var maxIds: [String?]? { get }
    
    var sinceIds: [String?]? { get }
    
    var maxSortIds: [Int64]? { get }
    
    var sinceSortIds: [Int64]? { get }
    
    var isLoadingMore: Bool { get }
    
}

extension RefreshTaskParam {
    var maxIds: [String?]? { return nil }
    
    var sinceIds: [String?]? { return nil }
    
    var maxSortIds: [Int64]? { return nil }
    
    var sinceSortIds: [Int64]? { return nil }
    
    var isLoadingMore: Bool { return false }
}
