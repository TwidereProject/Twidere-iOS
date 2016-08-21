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
    func parseJson(json: JSON, account: Account) {
        id = json["id_str"].string ?? json["id"].string ?? ""
    }
}