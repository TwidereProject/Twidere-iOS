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

class UserKeyArrayTransform: TransformType {
    typealias Object = UserKeyArray
    typealias JSON = [String]
    
    func transformFromJSON(_ value: Any?) -> UserKeyArray? {
        if let stringArray = value as? [String] {
            return UserKeyArray(stringArray.map { UserKey(rawValue: $0) })
        }
        return nil
    }
    
    func transformToJSON(_ value: UserKeyArray?) -> [String]? {
        if let userKey = value {
            return userKey.array.map{ $0.string }
        }
        return nil
    }
}
