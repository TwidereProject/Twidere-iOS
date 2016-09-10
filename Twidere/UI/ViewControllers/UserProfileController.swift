//
//  UserProfileController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    var navBarBackgroundBackup: UIImage!
    var navBarShadowImageBackup: UIImage!
    
    override func viewDidAppear(animated: Bool) {
        let navbar = navigationController!.navigationBar
        self.navBarBackgroundBackup = navbar.backgroundImageForBarMetrics(.Default)
        self.navBarShadowImageBackup = navbar.shadowImage
        navbar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navbar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(animated: Bool) {
        let navbar = navigationController!.navigationBar
        navbar.setBackgroundImage(self.navBarBackgroundBackup, forBarMetrics: .Default)
        navbar.shadowImage = self.navBarShadowImageBackup
    }
    
}