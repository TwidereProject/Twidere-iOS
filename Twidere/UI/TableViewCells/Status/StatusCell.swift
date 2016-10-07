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
import YYText

class StatusCell: ALSTableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: YYLabel!
    @IBOutlet weak var textView: YYLabel!
    @IBOutlet weak var timeView: ShortTimeView!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: YYLabel!
    @IBOutlet weak var quotedTextView: YYLabel!
    @IBOutlet weak var statusTypeLabelView: YYLabel!
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
        
        textView.highlightTapAction = self.highlightTapped
        quotedTextView.highlightTapAction = self.highlightTapped
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileImageViewFrame = profileImageView.convert(profileImageView.bounds, to: self)
        self.separatorInset.left = profileImageViewFrame.origin.x + profileImageViewFrame.width + profileImageView.layoutParams.marginTrailing
    }
    
    func display() {
        guard let status = self.status else {
            return
        }
        
        nameView.attributedText = StatusCell.createNameText(nameView.font.pointSize, name: status.userName, screenName: status.userScreenName, separator: " ")
        if (displayOption.linkHighlight) {
            textView.attributedText = StatusCell.createStatusText(status.textDisplay, displayOption: self.displayOption, metadata: status.metadata, displayRange: status.metadata?.displayRange)
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
                quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay!, displayOption: self.displayOption, metadata: status.quotedMetadata, displayRange: status.quotedMetadata?.displayRange)
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
    
    func highlightTapped(view: UIView, string: NSAttributedString, range: NSRange, rect: CGRect) {
        guard let highlight = string.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) as? YYTextHighlight else {
            return
        }
        guard let span = highlight.userInfo?["twidere.span"] as? SpanItem else {
            return
        }
        switch span {
        case let span as LinkSpanItem:
            break
        case let span as HashtagSpanItem:
            break
        case let span as MentionSpanItem:
            break
        default:
            break
        }
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
    
    static func createStatusText(_ text: String, displayOption: DisplayOption, metadata: Status.Metadata?, displayRange: [Int]?) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)

        attributed.yy_font = UIFont.systemFont(ofSize: displayOption.fontSize)
        
        metadata?.links?.applyToAttributedText(attributed, displayOption: displayOption)
        metadata?.mentions?.applyToAttributedText(attributed, displayOption: displayOption)
        metadata?.hashtags?.applyToAttributedText(attributed, displayOption: displayOption)
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
        var linkColor: UIColor = UIColor.darkText
        
        func loadUserDefaults() {
            self.fontSize = 15
            self.linkColor = UITextView.appearance().tintColor ?? materialLightBlue300
        }
    }
}

protocol StatusCellDelegate {
    func profileImageTapped(status: Status)
}
