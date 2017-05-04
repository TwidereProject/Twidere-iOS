//
//  Paging.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class Paging {
    fileprivate var params: [String: Any] = [:]
    
    var count: Int? {
        get { return params["count"] as? Int }
        set { params["count"] = newValue }
    }
    
    var maxId: String? {
        get { return params["max_id"] as? String }
        set { params["max_id"] = newValue }
    }
    
    var sinceId: String? {
        get { return params["since_id"] as? String }
        set { params["since_id"] = newValue }
    }
    
    var latestResults: Bool? {
        get { return params["latest_results"] as? Bool }
        set { params["latest_results"] = newValue }
    }
    
    var queries: [String: String] {
        var result = [String: String]()
        for (k, v) in params {
            result[k] = String(describing: v)
        }
        return result
    }
}
