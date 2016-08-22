//
//  UrlUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

private let twitterProfileImageRegex = "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_images/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)_(bigger|normal|mini|reasonably_small)(\\.?(png|jpeg|jpg|gif|bmp))?".r!

private let twitterDateFormatter: NSDateFormatter = {
    let f = NSDateFormatter()
    f.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    return f
}()

func getProfileImageUrlForSize(url: String, size: ProfileImageSize) -> String {
    if (twitterProfileImageRegex.matches(url)) {
        return twitterProfileImageRegex.replaceFirst(in: url, with: "$1$2/profile_images/$3/$4\(size.suffix)$6")
    }
    return url
}

func parseTwitterDate(str: String) -> NSDate? {
    return twitterDateFormatter.dateFromString(str)
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
