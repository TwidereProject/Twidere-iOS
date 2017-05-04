//
//  SpanItemExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/6.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import YYText
import TwidereCore

extension Array where Element: SpanItem {
    func applyToAttributedText(_ string: NSMutableAttributedString, linkColor: UIColor) {
        for span in self {
            string.yy_setTextHighlight(NSMakeRange(span.start, span.length), color: linkColor, backgroundColor: nil, userInfo: [highlightUserInfoKey: span])
        }
    }
    
}

let highlightUserInfoKey: String = "twidere.span"

extension SpanItem {
    
    var length: Int {
        return end - start
    }
    
    func createViewController(accountKey: UserKey) -> (UIViewController, Bool)? {
        switch self {
//        case let span as LinkSpanItem:
//            let vc = SafariBrowserController(url: URL(string: span.link)!)
//            return (vc, true)
//        case let span as HashtagSpanItem:
//            let vc = SafariBrowserController(url: URL(string: "https://twitter.com/search?q=\(span.hashtag)")!)
//            return (vc, true)
//        case let span as MentionSpanItem:
//            let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
//            vc.loadUser(userInfo: (accountKey, span.key, span.screenName))
//            return (vc, false)
        default:
            break
        }
        return nil
    }

}
