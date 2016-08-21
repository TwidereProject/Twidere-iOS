//
//  HomeRootController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import REFrostedViewController

class HomeRootController: UINavigationController, REFrostedViewControllerDelegate {
    func frostedViewController(frostedViewController: REFrostedViewController!, didShowMenuViewController menuViewController: UIViewController!) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    func frostedViewController(frostedViewController: REFrostedViewController!, didHideMenuViewController menuViewController: UIViewController!) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
}