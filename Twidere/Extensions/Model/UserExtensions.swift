//
//  UserExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON


extension User {
    
    func profileImageUrlForSize(_ size: ProfileImageSize) -> String? {
        guard let url = profileImageUrl else {
            return nil
        }
        return getProfileImageUrlForSize(url, size: size)
    }
    
    func profileBannerUrlForSize(_ size: Int) -> String? {
        guard let url = profileBannerUrl else {
            return nil
        }
        return getProfileBannerUrlForSize(url, size: size)
    }
    
}

extension User.Metadata {
    var backgroundUIColor: UIColor? {
        if let hex = backgroundColor, let color = UIColor(hexString: hex){
            return color
        }
        return nil
    }
}
