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
import MWPhotoBrowser

class StatusCell: ALSTableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: YYLabel!
    @IBOutlet weak var textView: TimelineContentTextView!
    @IBOutlet weak var timeView: ShortTimeView!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: YYLabel!
    @IBOutlet weak var quotedTextView: TimelineContentTextView!
    @IBOutlet weak var statusTypeLabelView: YYLabel!
    @IBOutlet weak var mediaPreview: MediaPreviewContainer!
    @IBOutlet weak var quotedMediaPreview: MediaPreviewContainer!
    @IBOutlet weak var actionsContainer: UIStackView!
    
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
            
            self.actionsContainer.layoutParams.hidden = displayOption.hideActions
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameView.displaysAsynchronously = true
        quotedNameView.displaysAsynchronously = true
        
        textView.displaysAsynchronously = true
        quotedTextView.displaysAsynchronously = true
        
        statusTypeLabelView.displaysAsynchronously = true
        
        self.profileImageView.isUserInteractionEnabled = true
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileImageTapped(_:))))
        
        self.quotedView.isUserInteractionEnabled = true
        self.quotedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.quotedViewTapped(_:))))
        
        self.mediaPreview.isUserInteractionEnabled = true
        self.mediaPreview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.mediaPreviewTapped(_:))))
        
        // Make profile image circular
        profileImageView.makeCircular()
        
        // Add borders to previews
        quotedView.layer.makeRoundedCorner(radius: 4.0)
        mediaPreview.layer.makeRoundedCorner(radius: 4.0)
        quotedMediaPreview.layer.makeRoundedCorner(radius: 4.0)
        
        // Name views has single line
        nameView.numberOfLines = 1
        quotedNameView.numberOfLines = 1
        
        // Text views has multiple lines
        textView.numberOfLines = 0
        quotedTextView.numberOfLines = 0
        
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
        if (status.retweetCreatedAt != nil) {
            timeView.time = status.retweetCreatedAt
        } else {
            timeView.time = status.createdAt
        }
    }
    
    @objc private func profileImageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.profileImageTapped(status: self.status)
    }
    
    @objc private func mediaPreviewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.mediaPreviewTapped(status: self.status)
    }
    
    @objc private func quotedViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.quotedViewTapped(status: self.status)
    }
    
    @objc private func highlightTapped(view: UIView, string: NSAttributedString, range: NSRange, rect: CGRect) {
        guard let highlight = string.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) as? YYTextHighlight else {
            return
        }
        guard let span = highlight.userInfo?[SpanItem.highlightUserInfoKey] as? SpanItem else {
            return
        }
        delegate?.spanItemTapped(status: self.status, span: span)
    }
    
    @IBAction func replyTapped(_ sender: TintedImageButton) {
        delegate.actionSelected(status: status, action: .reply)
    }
    
    @IBAction func retweetTapped(_ sender: TintedImageButton) {
        delegate.actionSelected(status: status, action: .retweet)
    }
    
    @IBAction func favoriteTapped(_ sender: TintedImageButton) {
        delegate.actionSelected(status: status, action: .favorite)
    }
    
    @IBAction func moreTapped(_ sender: TintedImageButton) {
        delegate.actionSelected(status: status, action: .more)
    }
    
    func previewViewController(for location: CGPoint) -> (vc: UIViewController, sourceRect: CGRect, shouldPresentViewController: Bool) {
        let views: [UIView] = [self.quotedView, self.mediaPreview, self.profileImageView, self.textView]
        for v in views {
            if (!v.convert(v.bounds, to: self).contains(location)) {
                continue
            }
            switch v {
            case self.profileImageView:
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
                vc.loadUser(userInfo: (status.accountKey, status.userKey, status.userScreenName))
                return (vc, v.convert(v.bounds, to: self), false)
            case self.textView:
                let tv = v as! YYLabel
                guard let layout = tv.textLayout, let text = tv.attributedText else {
                    break
                }
                let textPoint = self.convert(location, to: tv)
                let pos = Int(layout.textPosition(for: textPoint, lineIndex: layout.lineIndex(for: textPoint)))
                if (pos == NSNotFound) {
                    break
                }
                var highlightRange = NSMakeRange(0, 0)
                guard let highlight = text.attribute(YYTextHighlightAttributeName, at: pos, effectiveRange: &highlightRange) as? YYTextHighlight else {
                    break
                }
                let highlightRect = layout.rect(for: YYTextRange(range: highlightRange))
                guard let span = highlight.userInfo?[SpanItem.highlightUserInfoKey] as? SpanItem else {
                    break
                }
                guard let (vc, present) = span.createViewController(accountKey: status.accountKey) else {
                    break
                }
                return (vc, tv.convert(highlightRect, to: self), present)
            case self.quotedView:
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                vc.displayStatus(status.quotedStatus!, reload: true)
                return (vc, v.convert(v.bounds, to: self), false)
            case self.mediaPreview:
                let vc = MediaViewerController(media: status.metadata!.media!)
                if let item = status.metadata?.media?.first {
                    vc.preferredContentSize = CGSize(width: item.width, height: item.height)
                }
                return (vc, v.convert(v.bounds, to: self), false)
            default:
                break
            }
        }
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
        vc.displayStatus(status)
        return (vc, self.bounds, false)
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
        var hideActions: Bool = false
        
        func loadUserDefaults() {
            self.fontSize = 15
            self.linkColor = UITextView.appearance().tintColor ?? materialLightBlue300
        }
    }
    
    enum StatusAction {
        case reply, retweet, favorite, more
    }
}

protocol StatusCellDelegate {
    func profileImageTapped(status: Status)
    func mediaPreviewTapped(status: Status)
    func quotedViewTapped(status: Status)
    func spanItemTapped(status: Status, span: SpanItem)
    func actionSelected(status: Status, action: StatusCell.StatusAction)
}
