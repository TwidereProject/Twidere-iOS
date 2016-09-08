//
//  StatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SwiftyJSON
import DateTools
import ALSLayouts
import AttributedLabel

class StatusCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: AttributedLabel!
    @IBOutlet weak var textView: AttributedLabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: AttributedLabel!
    @IBOutlet weak var quotedTextView: AttributedLabel!
    @IBOutlet weak var statusTypeLabelView: UILabel!
    
    var status: FlatStatus! {
        didSet {
            display()
        }
    }
    
    var displayOption: DisplayOption! {
        didSet {
            quotedNameView.font = UIFont.systemFontOfSize(displayOption.fontSize * 0.9)
            nameView.font = UIFont.systemFontOfSize(displayOption.fontSize * 0.9)
            
            quotedTextView.font = UIFont.systemFontOfSize(displayOption.fontSize)
            textView.font = UIFont.systemFontOfSize(displayOption.fontSize)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeCircular()
        
        // border radius
        quotedView.layer.cornerRadius = 4.0
        
        // border
        quotedView.layer.borderColor = UIColor.lightGrayColor().CGColor
        quotedView.layer.borderWidth = 0.5
        // Initialization code
        
        nameView.numberOfLines = 1
        quotedNameView.numberOfLines = 1
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        let layout = contentView.subviews.first as! ALSBaseLayout
        var layoutSize = size
        layoutSize.width -= contentView.layoutMargins.left + contentView.layoutMargins.right
        layoutSize.height -= contentView.layoutMargins.top + contentView.layoutMargins.bottom
        var contentSize = layout.sizeThatFits(layoutSize)
        contentSize.width += contentView.layoutMargins.left + contentView.layoutMargins.right
        contentSize.height += contentView.layoutMargins.top + contentView.layoutMargins.bottom
        return contentSize
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func display() {
        guard let status = self.status else {
            return
        }
        
        nameView.attributedText = StatusCell.createNameText(nameView.font.pointSize, name: status.userName, screenName: status.userScreenName, separator: " ")
        if (displayOption.linkHighlight) {
            textView.attributedText = StatusCell.createStatusText(status.textDisplay, linkColor: textView.tintColor, metadata: status.metadata, displayRange: status.metadata?.displayRange)
        } else {
            textView.text = status.textDisplay
        }
        
        if (status.retweetId != nil) {
            statusTypeLabelView.text = "Retweeted by \((status.retweetedByUserName ?? "User"))"
            
            statusTypeLabelView.layoutParams.hidden = false
        } else {
            statusTypeLabelView.text = nil
            
            statusTypeLabelView.layoutParams.hidden = true
        }
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quotedUserName!, screenName: status.quotedUserScreenName!, separator: " ")
            if (displayOption.linkHighlight) {
                quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, linkColor: textView.tintColor, metadata: status.quotedMetadata, displayRange: status.quotedMetadata?.displayRange)
            } else {
                quotedTextView.text = status.quotedTextDisplay
            }
            
            quotedView.layoutParams.hidden = false
        } else {
            quotedView.layoutParams.hidden = true
        }
        profileImageView.displayImage(getProfileImageUrlForSize(status.userProfileImage, size: .ReasonablySmall))
        
        updateTime(status)
        
        let layout = contentView.subviews.first as! ALSRelativeLayout
        layout.setNeedsLayout()
    }
    
    dynamic func updateTime(obj: AnyObject?) {
        guard let status = obj as? FlatStatus where status.id == self.status?.id else {
            return
        }
        if (abs(status.createdAt.minutesAgo()) > 1) {
            timeView.text = status.createdAt.shortTimeAgoSinceNow()
        } else {
            timeView.text = "just now"
        }
        if (!AppDelegate.performingScroll) {
            let layout = contentView.subviews.first as! ALSRelativeLayout
            layout.setNeedsLayout()
        }
        performSelector(#selector(self.updateTime), withObject: obj, afterDelay: 10.0)
    }
    
    private static func createNameText(size: CGFloat, name: String, screenName: String, separator: String) -> NSAttributedString {
        let nameString = NSMutableAttributedString()
        nameString.appendAttributedString(NSAttributedString(string: name, attributes: [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(size)
            ]))
        nameString.appendAttributedString(NSAttributedString(string: separator))
        nameString.appendAttributedString(NSAttributedString(string: "@" + screenName, attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(size * 0.9)
            ]))
        return nameString
    }
    
    private static func createStatusText(text: String, linkColor: UIColor, metadata: FlatStatus.Metadata?, displayRange: [Int]?) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        metadata?.links?.forEach({ span in
            attributed.addAttributes(["link": span.link, NSForegroundColorAttributeName: linkColor], range: NSMakeRange(span.start, span.end - span.start))
        })
        metadata?.mentions?.forEach({ span in
            attributed.addAttributes(["link": span.key.string, NSForegroundColorAttributeName: linkColor], range: NSMakeRange(span.start, span.end - span.start))
        })
        metadata?.hashtags?.forEach({ span in
            attributed.addAttributes(["link": span.hashtag, NSForegroundColorAttributeName: linkColor], range: NSMakeRange(span.start, span.end - span.start))
        })
        if let range = displayRange {
            let start = range[0], len = range[1] - range[0]
            if (start >= 0 && len <= attributed.length) {
                return attributed.attributedSubstringFromRange(NSMakeRange(start, len))
            }
        }
        return attributed
    }
    
    class DisplayOption {
        var displayProfileImage: Bool = true
        var fontSize: CGFloat = 15
        var linkHighlight: Bool = true
    }
}
