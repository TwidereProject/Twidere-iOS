//
//  FiltersTabsController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class FiltersTabsController: UITabBarController {
    
    
    @IBAction func closeFilters(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}