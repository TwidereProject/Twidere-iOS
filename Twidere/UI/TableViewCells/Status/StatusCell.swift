//
//  StatusCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SwiftyJSON

class StatusCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var textView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeCircular()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayStatus(orig: JSON) {
        
        let status: JSON
         if (orig["retweeted_status"].isExists()) {
            status = orig["retweeted_status"]
         } else if (orig["quoted_status"].isExists()) {
            status = orig
         } else {
            status = orig
        }
        textView.text = status["text"].string
        let user = status["user"]
        let name = user["name"].stringValue
        let screenName = user["screen_name"].stringValue
        let nameString = NSMutableAttributedString()
        nameString.appendAttributedString(NSAttributedString(string: name, attributes: [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(nameView.font.pointSize)
            ]))
        nameString.appendAttributedString(NSAttributedString(string: " "))
        nameString.appendAttributedString(NSAttributedString(string: "@" + screenName, attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(nameView.font.pointSize * 0.9)
            ]))
        nameView.attributedText = nameString
        let profileImageUrl = user["profile_image_url_https"].string ?? user["profile_image_url"].stringValue
        profileImageView.displayImage(getProfileImageUrlForSize(profileImageUrl, size: .ReasonablySmall))
    }
    
}
