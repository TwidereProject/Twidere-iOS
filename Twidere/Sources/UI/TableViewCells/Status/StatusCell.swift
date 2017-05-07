//
//  StatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import DateTools
import ALSLayouts
import YYText
import TwidereCore

class StatusCell: ALSTableViewCell, StatusCellProtocol {
    
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
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retwetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    var delegate: StatusCellDelegate!
    
    var status: PersistableStatus! {
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
        nameView.attributedText = StatusCell.createNameText(nameView.font.pointSize, name: status.user_name!, screenName: status.user_screen_name!, separator: " ")
        
        if (displayOption.linkHighlight) {
            textView.attributedText = StatusCell.createStatusText(status.text_unescaped!, spans: status.spans, displayRange: status.extras?.display_text_range, font: textView.font, displayOption: self.displayOption)
        } else {
            textView.text = status.text_unescaped
        }
        
        if (status.retweet_id != nil) {
            statusTypeLabelView.text = "Retweeted by \(status.retweeted_by_user_name ?? "User")"
            
            statusTypeLabelView.layoutParams.hidden = false
        } else if let inReplyTo = status.in_reply_to_user_key {
            statusTypeLabelView.text = "In reply to \(status.in_reply_to_name ?? status.in_reply_to_screen_name ?? "User")"
            
            statusTypeLabelView.layoutParams.hidden = false
        } else {
            statusTypeLabelView.text = nil
            
            statusTypeLabelView.layoutParams.hidden = true
        }
        
        mediaPreview.displayMedia(status.metadata?.media)
        
        if (status.quoted_id != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quoted_user_name!, screenName: status.quoted_user_screen_name!, separator: " ")
            if (displayOption.linkHighlight) {
                quotedTextView.attributedText = StatusCell.createStatusText(status.quoted_text_unescaped!, spans: status.quoted_spans, displayRange: status.extras?.quoted_display_text_range, font: textView.font, displayOption: self.displayOption)
            } else {
                quotedTextView.text = status.quoted_text_unescaped
            }
            quotedMediaPreview.displayMedia(status.quotedMetadata?.media)
            quotedView.layoutParams.hidden = false
        } else {
            quotedView.layoutParams.hidden = true
        }
        profileImageView.displayImage(getProfileImageUrlForSize(status.user_profile_image_url!, size: .reasonablySmall))
        if (status.is_retweet) {
            timeView.time = Date(timeIntervalSince1970: TimeInterval(status.retweet_timestamp * 1000))
        } else {
            timeView.time = Date(timeIntervalSince1970: TimeInterval(status.timestamp * 1000))
        }
        
        if status.reply_count > 0 {
            replyButton.setTitle(" \(status.reply_count.shortLocalizedString)", for: .normal)
        } else {
            replyButton.setTitle(nil, for: .normal)
        }
        
        if status.retweet_count > 0 {
            retwetButton.setTitle(" \(status.retweet_count.shortLocalizedString)", for: .normal)
        } else {
            retwetButton.setTitle(nil, for: .normal)
        }
        if (status.my_retweet_id != nil) {
            retwetButton.imageView?.tintColor = materialLightGreen
        } else {
            retwetButton.imageView?.tintColor = nil
        }
        
        if status.favorite_count > 0 {
            favoriteButton.setTitle(" \(status.favorite_count.shortLocalizedString)", for: .normal)
        } else {
            favoriteButton.setTitle(nil, for: .normal)
        }
        if (status.is_favorite) {
            favoriteButton.imageView?.tintColor = materialAmber
        } else {
            favoriteButton.imageView?.tintColor = nil
        }
    }
    
    @objc private func profileImageTapped(_ sender: UITapGestureRecognizer) {
        delegate?.profileImageTapped(for: self, status: self.status)
    }
    
    @objc private func mediaPreviewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.mediaPreviewTapped(for: self, status: self.status)
    }
    
    @objc private func quotedViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.quotedViewTapped(for: self, status: self.status)
    }
    
    @objc private func highlightTapped(view: UIView, string: NSAttributedString, range: NSRange, rect: CGRect) {
        guard let span = string.yy_highlight(at: UInt(range.location))?.spanItem else {
            return
        }
        delegate?.spanItemTapped(for: self, status: self.status, span: span)
    }
    
    @IBAction func replyTapped(_ sender: ActionIconButton) {
        delegate.actionSelected(for: self, status: status, action: .reply)
    }
    
    @IBAction func retweetTapped(_ sender: ActionIconButton) {
        delegate.actionSelected(for: self, status: status, action: .retweet)
    }
    
    @IBAction func favoriteTapped(_ sender: ActionIconButton) {
        delegate.actionSelected(for: self, status: status, action: .favorite)
    }
    
    @IBAction func moreTapped(_ sender: ActionIconButton) {
        delegate.actionSelected(for: self, status: status, action: .more)
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
                vc.displayUser(user: status.user, reload: true)
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
                guard let span = highlight.userInfo?[highlightUserInfoKey] as? SpanItem else {
                    break
                }
                guard let (vc, present) = span.createViewController(accountKey: status.account_key) else {
                    break
                }
                return (vc, tv.convert(highlightRect, to: self), present)
            case self.quotedView:
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                vc.displayStatus(status.quotedStatus!, reload: true)
                return (vc, v.convert(v.bounds, to: self), false)
            case self.mediaPreview:
                if let item = status?.media?.first {
                    let vc = SafariBrowserController(url: URL(string: item.mediaUrl!)!)
                    return (vc, v.convert(v.bounds, to: self), true)
                }
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
    
    static func createStatusText(_ text: String, spans: [SpanItem]?, displayRange: [Int]?, font: UIFont, displayOption: DisplayOption) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)

        attributed.yy_font = font
        
        spans?.applyToAttributedText(attributed, linkColor: displayOption.linkColor)
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
            self.linkColor = UIApplication.shared.delegate!.window??.tintColor ?? UIColor.darkText
        }
    }
    
    enum StatusAction {
        case reply, retweet, favorite, share, more
    }
}

protocol StatusCellDelegate {
    func profileImageTapped(for cell: StatusCellProtocol, status: PersistableStatus)
    func mediaPreviewTapped(for cell: StatusCellProtocol, status: PersistableStatus)
    func quotedViewTapped(for cell: StatusCellProtocol, status: PersistableStatus)
    func spanItemTapped(for cell: StatusCellProtocol, status: PersistableStatus, span: SpanItem)
    func actionSelected(for cell: StatusCellProtocol, status: PersistableStatus, action: StatusCell.StatusAction)
}
