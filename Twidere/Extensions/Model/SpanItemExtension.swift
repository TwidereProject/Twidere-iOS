//
//  SpanItemExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/6.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import YYText

extension LinkSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "LinkSpanItem(link=\(self.link), display=\(self.display))"
    }
}

extension MentionSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "MentionSpanItem(key=\(self.key), name=\(self.name), screenName=\(self.screenName))"
    }
}

extension HashtagSpanItem: CustomDebugStringConvertible {
    var debugDescription: String {
        return "HashtagSpanItem(hashtag=\(self.hashtag))"
    }
}

extension Array where Element: SpanItem {
    func applyToAttributedText(_ string: NSMutableAttributedString, displayOption: StatusCell.DisplayOption) {
        for span in self {
            string.yy_setTextHighlight(NSMakeRange(span.start, span.end - span.start), color: displayOption.linkColor, backgroundColor: nil, userInfo: ["twidere.span": span])
        }
    }
}
