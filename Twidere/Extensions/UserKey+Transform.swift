//
//  UserKey+Transform.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import ObjectMapper

class UserKeyTransform: TransformType {
    
    typealias Object = UserKey
    typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> UserKey? {
        if let string = value as? String {
            return UserKey(rawValue: string)
        }
        return nil
    }
    
    func transformToJSON(_ value: UserKey?) -> String? {
        if let userKey = value {
            return userKey.string
        }
        return nil
    }
}
