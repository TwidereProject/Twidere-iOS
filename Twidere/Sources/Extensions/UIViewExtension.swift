//
//  UIViewExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/7.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCircular(border: CALayerBorder? = nil, shadow: CALayerShadow? = nil) {
        self.layer.makeCircular(border: border, shadow: shadow)
        
        self.clipsToBounds = true
        
    }
    
}
