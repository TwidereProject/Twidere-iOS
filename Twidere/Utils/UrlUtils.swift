//
//  UrlUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

let PATTERN_TWITTER_PROFILE_IMAGES = "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_images/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)_(bigger|normal|mini|reasonably_small)(\\.?(png|jpeg|jpg|gif|bmp))?".r!

func getProfileImageUrlForSize(url: String, size: ProfileImageSize) -> String {
    if (PATTERN_TWITTER_PROFILE_IMAGES.matches(url)) {
        return PATTERN_TWITTER_PROFILE_IMAGES.replaceFirst(in: url, with: "$1$2/profile_images/$3/$4\(size.suffix)$6")
    }
    return url
}

enum ProfileImageSize {
    case Bigger, Normal, Mini, ReasonablySmall, Original
    var suffix: String {
        get {
            switch self {
            case .Bigger:
                return "_bigger"
            case .Normal:
                return "_normal"
            case .Mini:
                return "_mini"
            case .ReasonablySmall:
                return "_reasonably_small"
            case .Original:
                return ""
            }
        }
    }
}