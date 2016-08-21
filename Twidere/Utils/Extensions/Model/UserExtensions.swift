//
//  UserExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Regex

extension User {
    
    func profileImageUrlForSize(size: ProfileImageSize) -> String? {
        guard let url = profileImageUrl else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
}