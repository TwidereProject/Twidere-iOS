//
//  UIRefreshControlExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    
    func beginRefreshingManually() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
    
}
