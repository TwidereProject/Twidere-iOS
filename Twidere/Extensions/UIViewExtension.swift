//
//  UIViewExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/7.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeCircular() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    
}
