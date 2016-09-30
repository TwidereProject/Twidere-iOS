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

class StatusCell: ALSTableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: AttributedLabel!
    @IBOutlet weak var textView: AttributedLabel!
    @IBOutlet weak var timeView: ShortTimeView!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: AttributedLabel!
    @IBOutlet weak var quotedTextView: AttributedLabel!
    @IBOutlet weak var statusTypeLabelView: AttributedLabel!
    @IBOutlet weak var mediaPreview: MediaPreviewContainer!
    @IBOutlet weak var quotedMediaPreview: MediaPreviewContainer!
    
    var delegate: StatusCellDelegate!
    
    var status: Status! {
        didSet {
            display()
        }
    }
    
    var displayOption: DisplayOption! {
        didSet {
            quotedNameView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.95)
            nameView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.95)
            
            timeView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.85)
            statusTypeLabelView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.9)
            
            quotedTextView.font = UIFont.systemFont(ofSize: displayOption.fontSize)
            textView.font = UIFont.systemFont(ofSize: displayOption.fontSize)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let profileImageViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.profileImageTapped(_:)))
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(profileImageViewTapRecognizer)
        
        profileImageView.makeCircular()
        
        // border radius
        quotedView.layer.cornerRadius = 4.0
        
        // border
        quotedView.layer.borderColor = UIColor.lightGray.cgColor
        quotedView.layer.borderWidth = 0.5
        // Initialization code
        
        nameView.numberOfLines = 1
        quotedNameView.numberOfLines = 1
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
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
        } else if let inReplyTo = status.metadata?.inReplyTo {
            statusTypeLabelView.text = "In reply to \((inReplyTo.userName ?? inReplyTo.userScreenName!))"
            
            statusTypeLabelView.layoutParams.hidden = false
        } else {
            statusTypeLabelView.text = nil
            
            statusTypeLabelView.layoutParams.hidden = true
        }
        
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
        profileImageView.displayImage(getProfileImageUrlForSize(status.userProfileImage, size: .reasonablySmall))
        timeView.time = status.createdAt
        
        let layout = contentView.subviews.first as! ALSRelativeLayout
        layout.setNeedsLayout()
    }
    
    @IBAction func profileImageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.profileImageTapped(status: self.status)
    }
    
    static func createNameText(_ size: CGFloat, name: String, screenName: String, separator: String) -> NSAttributedString {
        let nameString = NSMutableAttributedString()
        nameString.append(NSAttributedString(string: name, attributes: [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: size)
            ]))
        nameString.append(NSAttributedString(string: separator))
        nameString.append(NSAttributedString(string: "@" + screenName, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: size * 0.9)
            ]))
        return nameString
    }
    
    static func createStatusText(_ text: String, linkColor: UIColor, metadata: Status.Metadata?, displayRange: [Int]?) -> NSAttributedString {
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
            let len = range[1]
            if (len <= attributed.length) {
                return attributed.attributedSubstring(from: NSMakeRange(0, len))
            }
        }
        return attributed
    }
    
    class DisplayOption {
        var displayProfileImage: Bool = true
        var fontSize: CGFloat = 15
        var linkHighlight: Bool = true
        
        func loadUserDefaults() {
            self.fontSize = 15
        }
    }
}

protocol StatusCellDelegate {
    func profileImageTapped(status: Status)
}
