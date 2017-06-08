//
//  UrlUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

private let twitterProfileImageRegex = try! NSRegularExpression(pattern: "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_images/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)_(bigger|normal|mini|reasonably_small)(\\.?(png|jpeg|jpg|gif|bmp))?")
private let twitterBannerImageRegex = try! NSRegularExpression(pattern: "(https?://)?(twimg[\\d\\w\\-]+\\.akamaihd\\.net|[\\w\\d]+\\.twimg\\.com)/profile_banners/([\\d\\w\\-_]+)/([\\d\\w\\-_]+)(/[\\d\\w\\-_]+)?")

private let twitterDateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.locale = Locale(identifier: "en_US_POSIX")
    f.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    return f
}()

func getProfileImageUrlForSize(_ url: String, size: ProfileImageSize) -> String {
    let range = NSMakeRange(0, url.utf16.count)
    if (!twitterProfileImageRegex.matches(in: url, options: [], range: range).isEmpty) {
        return twitterProfileImageRegex.stringByReplacingMatches(in: url, options: [], range: range, withTemplate: "$1$2/profile_images/$3/$4\(size.suffix)$6")
    }
    return url
}

func getProfileBannerUrlForSize(_ url: String, size: Int) -> String {
    let range = NSMakeRange(0, url.utf16.count)
    if (!twitterBannerImageRegex.matches(in: url, options: [], range: range).isEmpty) {
        return twitterBannerImageRegex.stringByReplacingMatches(in: url, options: [], range: range, withTemplate: "$1$2/profile_banners/$3/$4/\(getBestBannerType(size))")
    }
    return url
}

func getBestBannerType(_ width: Int) -> String {
    switch width {
    case 0...320:
        return "mobile"
    case 321...520:
        return "web"
    case 521...626:
        return "ipad";
    case 627...640:
        return "mobile_retina"
    case 641...1040:
        return "web_retina"
    default:
        return "ipad_retina"
    }
}

func parseTwitterDate(_ str: String) -> Date! {
    return twitterDateFormatter.date(from: str)
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
