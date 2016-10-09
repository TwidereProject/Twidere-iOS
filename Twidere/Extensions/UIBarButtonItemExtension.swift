//
//  UIBarButtonItemExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/23.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

private var originalImageKey: UInt8 = 0

extension UIBarButtonItem {
    
    func makeShadowed(_ shadow: NSShadow) {
        let origImage: UIImage?
        if let obj = objc_getAssociatedObject(self, &originalImageKey) as? UIImage {
            origImage = obj
        } else {
            origImage = self.image
            objc_setAssociatedObject(self, &originalImageKey, origImage, .OBJC_ASSOCIATION_RETAIN)
        }
        self.image = origImage?.withShadow(shadow).withRenderingMode(.alwaysOriginal)
    }
}
