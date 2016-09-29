//
//  Activity+MicroBlog.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Activity {
    convenience init(_ json: JSON, accountKey: UserKey?) {
        self.init()
        self.accountKey = accountKey
    }
    
    static func arrayFromJson(_ json: JSON, accountKey: UserKey) -> [Activity] {
        if let array = json.array {
            return array.map { Activity($0, accountKey: accountKey) }
        } else {
            return json["statuses"].map { Activity($1, accountKey: accountKey) }
        }
    }
    
}
