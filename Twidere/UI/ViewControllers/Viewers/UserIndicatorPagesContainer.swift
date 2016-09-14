//
//  UserIndicatorPagesContainer.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import ALSLayouts

class UserIndicatorPagesContainer: ALSLinearLayout {
    
    var contentHeight: CGFloat = 0
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        if (contentHeight.isZero) {
            return size
        }
        return CGSizeMake(size.width, contentHeight)
    }
}