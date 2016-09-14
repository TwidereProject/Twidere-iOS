//
//  UrlUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

private let twitterProfileImageRegex = "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_images/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)_(bigger|normal|mini|reasonably_small)(\\.?(png|jpeg|jpg|gif|bmp))?".r!
private let twitterBannerImageRegex = "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_banners/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)(/[\\d\\w\\-_]+)?".r!

private let twitterDateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    return f
}()

func getProfileImageUrlForSize(_ url: String, size: ProfileImageSize) -> String {
    if (twitterProfileImageRegex.matches(url)) {
        return twitterProfileImageRegex.replaceFirst(in: url, with: "$1$2/profile_images/$3/$4\(size.suffix)$6")
    }
    return url
}

func getProfileBannerUrlForSize(_ url: String, size: Int) -> String {
    if (twitterBannerImageRegex.matches(url)) {
        return twitterBannerImageRegex.replaceFirst(in: url, with: "$1$2/profile_banners/$3/$4/\(getBestBannerType(size))")
    }
    return url
}

func getBestBannerType(_ width: Int) -> String {
    switch width {
    case  0...320:
        return "mobile";
    case 321...520:
        return "web";
    case 521...626:
        return "ipad";
    case 627...640:
        return "mobile_retina";
    case 641...1040:
        return "web_retina";
    default:
        return "ipad_retina";
    }
}

func parseTwitterDate(_ str: String) -> Date? {
    return twitterDateFormatter.date(from: str)
}

func getTwitterEntityId(_ json: JSON) -> String {
    return json["id_str"].string ?? json["id"].stringValue
}

enum ProfileImageSize {
    case bigger, normal, mini, reasonablySmall, original
    var suffix: String {
        get {
            switch self {
            case .bigger:
                return "_bigger"
            case .normal:
                return "_normal"
            case .mini:
                return "_mini"
            case .reasonablySmall:
                return "_reasonably_small"
            case .original:
                return ""
            }
        }
    }
}
