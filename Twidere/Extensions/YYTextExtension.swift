//
//  YYTextExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/18.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import YYText

extension NSMutableAttributedString {
    
    func yy_appendTextHighlight(string: String, color: UIColor?, backgroundColor: UIColor?, userInfo: [AnyHashable: Any], tapAction: YYTextAction? = nil, longPressAction: YYTextAction? = nil) {
        var range = NSMakeRange(self.length, 0)
        self.yy_appendString(string)
        range.length = self.length - range.location
        self.yy_setTextHighlight(range, color: color, backgroundColor: backgroundColor, userInfo: userInfo, tapAction: tapAction, longPressAction: longPressAction)
    }
    
    
    func yy_appendStringRemoveHighlight(_ string: String) {
        let emptyBefore = string.isEmpty
        var range = NSMakeRange(self.length, 0)
        self.yy_appendString(string)
        range.length = self.length - range.location
        if !emptyBefore, let font = self.yy_font(at: UInt(range.location)) {
            self.yy_removeAttributes(in: range)
            self.yy_setFont(font, range: range)
        }
    }
    
    func yy_appendAttachment(with content: Any?, contentMode: UIViewContentMode = .scaleToFill, attachmentSize: CGSize, alignTo font: UIFont, alignment: YYTextVerticalAlignment) {
        let attachment = YYTextAttachment(content: content)
        attachment.contentMode = contentMode
        var range = NSMakeRange(self.length, 0)
        self.yy_appendString(YYTextAttachmentToken)
        range.length = self.length - range.location
        
        self.yy_setTextAttachment(attachment, range: range)
        
        let delegate = YYTextRunDelegate()
        delegate.width = attachmentSize.width
        
        switch (alignment) {
        case .top:
            delegate.ascent = font.ascender;
            delegate.descent = attachmentSize.height - font.ascender;
            if (delegate.descent < 0) {
                delegate.descent = 0
                delegate.ascent = attachmentSize.height
            }
        case .center:
            let fontHeight: CGFloat = font.ascender - font.descender
            let yOffset: CGFloat = font.ascender - fontHeight * 0.5
            delegate.ascent = attachmentSize.height * 0.5 + yOffset
            delegate.descent = attachmentSize.height - delegate.ascent
            if (delegate.descent < 0) {
                delegate.descent = 0
                delegate.ascent = attachmentSize.height
            }
        case .bottom:
            delegate.ascent = attachmentSize.height + font.descender
            delegate.descent = -font.descender
            if (delegate.ascent < 0) {
                delegate.ascent = 0
                delegate.descent = attachmentSize.height
            }
        }
        
        if let delegateRef = delegate.ctRunDelegate() {
            self.yy_setRunDelegate(delegateRef, range: range)
        }
    }
    
}

extension NSAttributedString {
    
    func yy_highlight(at: UInt) -> YYTextHighlight? {
        return yy_attribute(YYTextHighlightAttributeName, at: at) as? YYTextHighlight
    }
}

extension YYTextHighlight {
    var spanItem: SpanItem? {
        return userInfo?[highlightUserInfoKey] as? SpanItem
    }
}
