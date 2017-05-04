//
//  NSShadowExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/25.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension NSShadow {
    func shadowedImageInset(size: CGSize) -> UIEdgeInsets {
        let border = CGSize(width: fabs(shadowOffset.width) + shadowBlurRadius, height: fabs(shadowOffset.height) + shadowBlurRadius)
        return UIEdgeInsetsMake(border.height, -border.width, border.height, -border.width)
    }
}
