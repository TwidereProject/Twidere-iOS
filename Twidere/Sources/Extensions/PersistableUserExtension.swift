//
//  PersistableUserExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/5.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation
import TwidereCore

extension PersistableUser {
    
    private static let twitterProfileImageRegex = try! NSRegularExpression(pattern: "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_images/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)_(bigger|normal|mini|reasonably_small)(\\.?(png|jpeg|jpg|gif|bmp))?")
    
    func getProfileImageUrl(forSize size: ProfileImageSize) -> String! {
        guard let url = profile_image_url else {
            return nil
        }
        let range = NSMakeRange(0, url.utf16.count)
        if (!PersistableUser.twitterProfileImageRegex.matches(in: url, options: [], range: range).isEmpty) {
            return PersistableUser.twitterProfileImageRegex.stringByReplacingMatches(in: url, options: [], range: range, withTemplate: "$1$2/profile_images/$3/$4\(size.suffix)$6")
        }
        return url
    }
}
