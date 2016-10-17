//
//  DetailStatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import YYText
import DateTools
import ALSLayouts
import Kanna

class DetailStatusCell: ALSTableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameView: YYLabel!
    @IBOutlet weak var timeSourceView: YYLabel!
    @IBOutlet weak var textView: YYLabel!
    @IBOutlet weak var mediaPreview: MediaPreviewContainer!
    @IBOutlet weak var quotedView: ALSLinearLayout!
    @IBOutlet weak var quotedNameView: YYLabel!
    @IBOutlet weak var quotedTextView: YYLabel!
    @IBOutlet weak var quotedMediaPreview: MediaPreviewContainer!
    @IBOutlet weak var statusToolbar: UIToolbar!

    var displayOption: StatusCell.DisplayOption!

    override func awakeFromNib() {
        textView.numberOfLines = 0
        quotedTextView.numberOfLines = 0
        
        
        userProfileImageView.makeCircular()
        
        // Make views rounded corner
        quotedView.layer.makeRoundedCorner(radius: 4.0)
        mediaPreview.layer.makeRoundedCorner(radius: 4.0)
        
        userNameView.numberOfLines = 1
        timeSourceView.numberOfLines = 1
        fd_enforceFrameLayout = true
        
        statusToolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        statusToolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        self.contentView.layoutMargins = UIEdgeInsets.zero
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separatorInset = UIEdgeInsets.zero
    }

    func display(_ status: Status) {
        let nameFontSize: CGFloat = displayOption.fontSize * 1.05
        let textFont: UIFont = UIFont.systemFont(ofSize: displayOption.fontSize * 1.2)
        let timeSourceFont: UIFont = UIFont.systemFont(ofSize: displayOption.fontSize * 0.9)
        userNameView.attributedText = StatusCell.createNameText(nameFontSize, name: status.userName, screenName: status.userScreenName, separator: " ")
        timeSourceView.attributedText = createTimeSourceText(createdAt: status.createdAt, source: status.source, font: timeSourceFont)
        userProfileImageView.displayImage(status.userProfileImageForSize(.reasonablySmall))

        textView.attributedText = StatusCell.createStatusText(status.textDisplay, metadata: status.metadata, displayRange: status.metadata?.displayRange, font: textFont, displayOption: self.displayOption)
        mediaPreview.displayMedia(status.metadata?.media)
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(nameFontSize, name: status.quotedUserName!, screenName: status.quotedUserScreenName!, separator: " ")
            if (displayOption.linkHighlight) {
                quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, metadata: status.quotedMetadata, displayRange: status.quotedMetadata?.displayRange, font: textFont, displayOption: self.displayOption)
            } else {
                quotedTextView.text = status.quotedTextDisplay
            }
            quotedMediaPreview.displayMedia(status.quotedMetadata?.media)
            quotedView.layoutParams.hidden = false
        } else {
            quotedView.layoutParams.hidden = true
        }
    }

    func createTimeSourceText(createdAt: Date, source: String?, font: UIFont) -> NSAttributedString {
        let string = NSMutableAttributedString(string: (createdAt as NSDate).formattedDate(with: .long))
        string.yy_font = font
        if let source = source {
            string.yy_appendString(" \u{00B7} ")
            if let html = Kanna.HTML(html: source, encoding: .utf8), let anchor = html.at_css("a"), let href = anchor["href"], let content = anchor.text {
                let attributedSource = NSMutableAttributedString(string: content)
                attributedSource.yy_font = font
                attributedSource.yy_setTextHighlight(attributedSource.yy_rangeOfAll(), color: displayOption.linkColor, backgroundColor: nil, userInfo: [highlightUserInfoKey: LinkSpanItem(link: href, display: content)])
                string.append(attributedSource)
            } else {
                string.yy_appendString(source)
            }
        }
        return string
    }
}
