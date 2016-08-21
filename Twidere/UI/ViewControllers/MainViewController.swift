//
//  ViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/5/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SugarRecord
import REFrostedViewController

class MainViewController: UIViewController {
    
    var hasAccount: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        do {
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStorage
            hasAccount = try (!db.fetch(Request<Account>()).isEmpty)
        } catch {
            hasAccount = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (hasAccount) {
            
            // Create content and menu controllers
            //
            let homeController = storyboard!.instantiateViewControllerWithIdentifier("HomeRoot") as! HomeRootController
            let menuController = storyboard!.instantiateViewControllerWithIdentifier("NavMenu")
            
            // Create frosted view controller
            //
            let frostedViewController = REFrostedViewController(contentViewController: homeController, menuViewController: menuController)
            frostedViewController.direction = .Left
            frostedViewController.panGestureEnabled = true
            frostedViewController.limitMenuViewSize = true
            frostedViewController.delegate = homeController
            
            presentViewController(frostedViewController, animated: false, completion: nil)
        } else {
            
            performSegueWithIdentifier("ShowSignIn", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

