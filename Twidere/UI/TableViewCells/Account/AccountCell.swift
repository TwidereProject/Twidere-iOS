//
//  AccountCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import ALSLayouts
import UIKit

class AccountCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var screenNameView: UILabel!
    
    override func awakeFromNib() {
        profileImageView.makeCircular()
    }
    
    func display(_ account: Account) {
        self.nameView.text = account.user.name
        self.screenNameView.text = account.user.screenName
        self.profileImageView.displayImage(account.user.profileImageUrlForSize(.reasonablySmall))
        
        let layout = contentView.subviews.first as! ALSBaseLayout
        layout.setNeedsLayout()
    }
}
