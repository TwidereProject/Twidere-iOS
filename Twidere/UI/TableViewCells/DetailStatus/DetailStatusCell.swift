//
//  DetailStatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import AttributedLabel
import DateTools
import ALSLayouts
import UIView_FDCollapsibleConstraints

class DetailStatusCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameView: AttributedLabel!
    @IBOutlet weak var timeSourceView: AttributedLabel!
    @IBOutlet weak var textView: AttributedLabel!
    @IBOutlet weak var mediaPreview: MediaPreviewContainer!
    @IBOutlet weak var quotedView: ALSLinearLayout!
    @IBOutlet weak var quotedNameView: AttributedLabel!
    @IBOutlet weak var quotedTextView: AttributedLabel!
    @IBOutlet weak var quotedMediaPreview: MediaPreviewContainer!

    var displayOption: StatusCell.DisplayOption! {
        didSet {
            userNameView.font = UIFont.systemFontOfSize(displayOption.fontSize * 1.1)
            timeSourceView.font = UIFont.systemFontOfSize(displayOption.fontSize * 0.9)
            textView.font = UIFont.systemFontOfSize(displayOption.fontSize * 1.1)
        }
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return sizeThatFitsALS(size)
    }

    override func awakeFromNib() {
        userProfileImageView.makeCircular()
        userNameView.numberOfLines = 1
        timeSourceView.numberOfLines = 1
        fd_enforceFrameLayout = true
    }

    func display(_ status: Status) {
        userNameView.attributedText = StatusCell.createNameText(16, name: status.userName, screenName: status.userScreenName, separator: " ")
        timeSourceView.attributedText = createTimeSourceText(status.createdAt)
        userProfileImageView.displayImage(status.userProfileImageForSize(.reasonablySmall))

        textView.attributedText = StatusCell.createStatusText(status.textDisplay, linkColor: textView.tintColor, metadata: status.metadata, displayRange: status.metadata?.displayRange)
        mediaPreview.displayMedia(status.metadata?.media)
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quotedUserName!, screenName: status.quotedUserScreenName!, separator: " ")
            if (displayOption.linkHighlight) {
                quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, linkColor: textView.tintColor, metadata: status.quotedMetadata, displayRange: status.quotedMetadata?.displayRange)
            } else {
                quotedTextView.text = status.quotedTextDisplay
            }
            quotedMediaPreview.displayMedia(status.quotedMetadata?.media)
            quotedView.layoutParams.hidden = false
        } else {
            quotedView.layoutParams.hidden = true
        }
        
        let layout = contentView.subviews.first as! ALSRelativeLayout
        layout.setNeedsLayout()
    }

    func createTimeSourceText(_ createdAt: Date) -> NSAttributedString {
        let string = NSAttributedString(string: (createdAt as NSDate).formattedDate(with: .long))
        return string
    }
}
