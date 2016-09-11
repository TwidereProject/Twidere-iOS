//
//  BannerImageView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class BannerImageView: UIImageView {
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(size.width, size.width / 2)
    }
    
}