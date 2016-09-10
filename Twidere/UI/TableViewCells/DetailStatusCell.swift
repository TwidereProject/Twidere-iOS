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
import UIView_FDCollapsibleConstraints

class DetailStatusCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameView: AttributedLabel!
    @IBOutlet weak var timeSourceView: AttributedLabel!
    @IBOutlet weak var textView: AttributedLabel!

    var displayOption: StatusCell.DisplayOption! {
        didSet {
            userNameView.font = UIFont.systemFontOfSize(displayOption.fontSize * 1.1)
            timeSourceView.font = UIFont.systemFontOfSize(displayOption.fontSize * 0.9)
            textView.font = UIFont.systemFontOfSize(displayOption.fontSize * 1.1)
        }
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        return sizeThatFitsALS(size)
    }

    override func awakeFromNib() {
        userProfileImageView.makeCircular()
        fd_enforceFrameLayout = true
    }

    func display(status: FlatStatus) {
        userNameView.attributedText = StatusCell.createNameText(16, name: status.userName, screenName: status.userScreenName, separator: " ")
        timeSourceView.attributedText = createTimeSourceText(status.createdAt)
        userProfileImageView.displayImage(status.userProfileImageForSize(.ReasonablySmall))

        textView.attributedText = StatusCell.createStatusText(status.textDisplay, linkColor: textView.tintColor, metadata: status.metadata, displayRange: status.metadata?.displayRange)
    }

    func createTimeSourceText(createdAt: NSDate) -> NSAttributedString {
        let string = NSAttributedString(string: createdAt.formattedDateWithStyle(.LongStyle))
        return string
    }
}