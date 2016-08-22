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
    
    func displayStatus(status: FlatStatus) {
        textView.text = status.textUnescaped
        let nameString = NSMutableAttributedString()
        nameString.appendAttributedString(NSAttributedString(string: status.userName, attributes: [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(nameView.font.pointSize)
            ]))
        nameString.appendAttributedString(NSAttributedString(string: " "))
        nameString.appendAttributedString(NSAttributedString(string: "@" + status.userScreenName, attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(nameView.font.pointSize * 0.9)
            ]))
        nameView.attributedText = nameString
        profileImageView.displayImage(getProfileImageUrlForSize(status.userProfileImage, size: .ReasonablySmall))
    }
    
}
