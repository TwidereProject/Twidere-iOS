//
//  Paging.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

class Paging {
    fileprivate var params: [String: AnyObject] = [:]
    
    var count: Int {
        get { return params["count"] as! Int }
        set { params["count"] = newValue as AnyObject? }
    }
    
    var maxId: String {
        get { return params["max_id"] as! String }
        set { params["max_id"] = newValue as AnyObject? }
    }
    
    var sinceId: String {
        get { return params["since_id"] as! String }
        set { params["since_id"] = newValue as AnyObject? }
    }
    
    var latestResults: Bool {
        get { return params["latest_results"] as! Bool }
        set { params["latest_results"] = newValue as AnyObject? }
    }
    
    var queries: [String: String] {
        var result = [String: String]()
        for (k, v) in params {
            result[k] = String(describing: v)
        }
        return result
    }
}
