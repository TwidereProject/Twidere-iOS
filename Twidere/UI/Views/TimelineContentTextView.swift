//
//  TimelineContentTextView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import YYText

class TimelineContentTextView: YYLabel {
    
    override var attributedText: NSAttributedString? {
        get { return super.attributedText }
        set {
            if (newValue?.string == super.attributedText?.string) {
                return
            }
            self.clearContentsBeforeAsynchronouslyDisplay = true
            super.attributedText = newValue
            self.clearContentsBeforeAsynchronouslyDisplay = false
        }
    }
    
    override var text: String? {
        get { return super.text }
        set {
            self.clearContentsBeforeAsynchronouslyDisplay = true
            super.text = newValue
            self.clearContentsBeforeAsynchronouslyDisplay = false
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let boundsBackup = self.bounds
        self.bounds = CGRect.zero
        let result = super.sizeThatFits(size)
        self.bounds = boundsBackup
        return result
    }
    
}
