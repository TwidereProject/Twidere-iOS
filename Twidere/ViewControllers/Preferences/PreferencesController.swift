//
//  PreferencesController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class PreferencesController: BasePreferencesController {

    @IBAction func closeSettings(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
