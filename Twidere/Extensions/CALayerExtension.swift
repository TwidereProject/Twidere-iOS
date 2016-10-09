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
    
}
