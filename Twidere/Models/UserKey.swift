//
//  UserKey.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

struct UserKey {
    var id: String
    var host: String?

    init(id: String, host: String?) {
        self.id = id
        self.host = host
    }
}