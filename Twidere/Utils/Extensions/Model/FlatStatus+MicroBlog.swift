//
//  FlatStatus+JSON.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension FlatStatus {
    convenience init(json: JSON, account: Account) {
        self.init()
        self.accountKey = UserKey(str: account.accountKey!)
        self.id = json["id_str"].string ?? json["id"].stringValue
        self.createdAt = parseTwitterDate(json["created_at"].stringValue)?.timeIntervalSince1970Millis ?? -1
        
    }
}