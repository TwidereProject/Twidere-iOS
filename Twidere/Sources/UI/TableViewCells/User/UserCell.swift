//
//  UserCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import TwidereCore

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.makeCircular()
        // Initialization code
    }
    
    func displayUser(_ user: PersistableUser) {
        let name = user["name"].stringValue
        let screenName = user["screen_name"].stringValue
        let nameString = NSMutableAttributedString()
        nameString.append(NSAttributedString(string: name, attributes: [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: nameView.font.pointSize)
            ]))
        nameString.append(NSAttributedString(string: "\n"))
        nameString.append(NSAttributedString(string: "@" + screenName, attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: nameView.font.pointSize * 0.9)
            ]))
        nameView.attributedText = nameString
        let profileImageUrl = user["profile_image_url_https"].string ?? user["profile_image_url"].stringValue
        
        descriptionView.text = user["description"].string
        
        profileImageView.displayImage(getProfileImageUrlForSize(profileImageUrl, size: .reasonablySmall))
    }
    
}
