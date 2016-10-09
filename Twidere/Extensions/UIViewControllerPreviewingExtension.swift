//
//  UIViewControllerPreviewingExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

private var shouldPresentViewControllerKey: UInt = 0

extension UIViewControllerPreviewing {
    
    var shouldPresentViewController: Bool {
        get { return (objc_getAssociatedObject(self, &shouldPresentViewControllerKey) as? Bool) == true }
        set { objc_setAssociatedObject(self, &shouldPresentViewControllerKey, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    
}
