//
//  CALayerExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension CALayer {
    
    func makeRoundedCorner(radius: CGFloat, borderColor: CGColor = UIColor.lightGray.cgColor, borderWidth: CGFloat = 0.5) {
        self.cornerRadius = radius
        
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    func makeCircular(border: CALayerBorder? = nil, shadow: CALayerShadow? = nil) {
        self.cornerRadius = self.frame.size.width / 2
        self.masksToBounds = true
        
        if let border = border {
            self.borderColor = border.color
            self.borderWidth = border.width
        }
        
        if let shadow = shadow {
            self.shadowOffset = shadow.offset
            self.shadowRadius = shadow.blurRadius
            self.shadowColor = shadow.color
            self.shadowOpacity = shadow.opacity
            self.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).cgPath
        }
        
    }
    
}

struct CALayerBorder {
    var color: CGColor = UIColor.clear.cgColor
    var width: CGFloat = 1
}

struct CALayerShadow {
    var color: CGColor
    var offset: CGSize
    var blurRadius: CGFloat
    var opacity: Float
}
