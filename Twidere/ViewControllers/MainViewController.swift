//
//  ViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/5/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SugarRecord

class MainViewController: UIViewController {
    
    var hasAccount: Bool = false
    lazy var db: CoreDataDefaultStorage = {
        return AppDelegate.coreDataStorage()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            hasAccount = try (!db.fetch(Request<Account>()).isEmpty)
        } catch {
            hasAccount = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (hasAccount) {
            performSegueWithIdentifier("ShowHome", sender: self)
        } else {
            performSegueWithIdentifier("ShowSignIn", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

