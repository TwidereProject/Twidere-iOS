//
//  ShortTimeView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import YYText

class ShortTimeView: YYLabel {
    var time: Date! {
        didSet {
            self.updateTime(time)
        }
    }
    
    @objc private func updateTime(_ time: Date!) {
        guard let date: NSDate = time as NSDate?, self.time == time else {
            return
        }
        if (abs(date.minutesAgo()) > 1) {
            self.text = date.shortTimeAgoSinceNow()
        } else {
            self.text = "just now"
        }
        if (!AppDelegate.performingScroll) {
            superview?.setNeedsLayout()
        }
        perform(#selector(self.updateTime), with: time, afterDelay: 10.0)
    }
}
