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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            let db = coreDataStorage()
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
    
    
    func coreDataStorage() -> CoreDataDefaultStorage {
        let store = CoreData.Store.Named("twidere")
        let bundle = NSBundle(forClass: self.classForCoder)
        let model = CoreData.ObjectModel.Merged([bundle])
        let defaultStorage = try! CoreDataDefaultStorage(store: store, model: model)
        return defaultStorage
    }

}

