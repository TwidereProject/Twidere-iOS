//
// Created by Mariotaku Lee on 16/7/30.
// Copyright (c) 2016 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

class FlatStatus {
    var id: String!
    
    func parseJson(json: JSON, account: Account) {
        id = json["id_str"].string ?? json["id"].string ?? ""
    }
}
