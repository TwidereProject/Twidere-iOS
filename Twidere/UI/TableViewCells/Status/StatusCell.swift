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

class StatusCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: UILabel!
    @IBOutlet weak var quotedTextView: UILabel!
    @IBOutlet weak var statusTypeLabelView: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var status: FlatStatus! {
        didSet {
            display()
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
        textView.attributedText = StatusCell.createStatusText(status.textDisplay, spans: status.metadata?.spans, displayRange: status.metadata?.displayRange)
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quotedUserName!, screenName: status.quotedUserScreenName!, separator: " ")
        
            quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, spans: status.quotedMetadata?.spans, displayRange: status.quotedMetadata?.displayRange)
            
            quotedView.layoutHidden = false
        } else {
            quotedNameView.text = nil
            quotedTextView.text = nil
            
            quotedView.layoutHidden = true
        }
        profileImageView.displayImage(getProfileImageUrlForSize(status.userProfileImage, size: .ReasonablySmall))
        
        updateTime(status)
        
        setNeedsLayout()
    }
    
    dynamic func updateTime(obj: AnyObject?) {
        guard let status = obj as? FlatStatus where status.id == self.status?.id else {
            return
        }
        timeView.text = status.createdAt.shortTimeAgoSinceNow()
        performSelector(#selector(self.updateTime), withObject: obj, afterDelay: 5.0)
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
    
    private static func createStatusText(text: String, spans: [SpanItem]?, displayRange: [Int]?) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        spans?.forEach({ span in
            attributed.addAttribute(NSLinkAttributeName, value: span.link, range: NSMakeRange(span.start, span.end - span.start))
        })
        if (displayRange != nil) {
//            return attributed.attributedSubstringFromRange(NSMakeRange(0, displayRange![1]))
        }
        return attributed
    }
    
}
