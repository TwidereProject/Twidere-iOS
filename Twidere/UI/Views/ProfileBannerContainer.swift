//
//  BannerImageView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class ProfileBannerContainer: UIView {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: size.width / 3)
    }
    
    override func layoutSubviews() {
        var frame = self.frame
        frame.origin = CGPoint.zero
        for subview in subviews {
            subview.frame = frame
        }
    }
    
}
