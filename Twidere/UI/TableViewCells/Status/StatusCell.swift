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
import UIView_FDCollapsibleConstraints

class StatusCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var timeView: UILabel!
    @IBOutlet weak var quotedView: UIView!
    @IBOutlet weak var quotedNameView: UILabel!
    @IBOutlet weak var quotedTextView: UILabel!
    
    private var currentId: String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeCircular()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayStatus(status: FlatStatus) {
        currentId = status.id
        
        nameView.attributedText = StatusCell.createNameText(nameView.font.pointSize, name: status.userName, screenName: status.userScreenName, separator: " ")
        textView.attributedText = StatusCell.createStatusText(status.textDisplay, spans: status.metadata?.spans, displayRange: status.metadata?.displayRange)
        
        if (status.quotedId != nil) {
            quotedNameView.attributedText = StatusCell.createNameText(quotedNameView.font.pointSize, name: status.quotedUserName, screenName: status.quotedUserScreenName, separator: " ")
        
            quotedTextView.attributedText = StatusCell.createStatusText(status.quotedTextDisplay, spans: status.quotedMetadata?.spans, displayRange: status.quotedMetadata?.displayRange)
            quotedView.fd_collapsed = false
        } else {
            quotedView.fd_collapsed = true
        }
        profileImageView.displayImage(getProfileImageUrlForSize(status.userProfileImage, size: .ReasonablySmall))
        
        updateTime(status)
    }
    
    func updateTime(obj: AnyObject?) {
        guard let status = obj as? FlatStatus where status.id == currentId else {
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
            return attributed.attributedSubstringFromRange(NSMakeRange(displayRange![0], displayRange![1] - displayRange![0]))
        }
        return attributed
    }
    
}
