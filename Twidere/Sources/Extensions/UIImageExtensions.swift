//
//  UIImageExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/23.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import UIKit
import FXImageView

extension UIImage {
    
    static func withColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func withShadow(_ shadow: NSShadow) -> UIImage {
        return self.withShadowColor(shadow.shadowColor! as! UIColor, offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius)
    }
}

