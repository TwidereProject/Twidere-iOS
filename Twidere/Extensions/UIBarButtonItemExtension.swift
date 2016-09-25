//
//  UIBarButtonItemExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/23.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    func makeShadowed(_ shadow: NSShadow) {
        self.image = self.image?.withShadow(shadow).withRenderingMode(.alwaysOriginal)
    }
}
