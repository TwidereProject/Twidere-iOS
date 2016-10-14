//
//  ViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/5/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var hasAccount: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        hasAccount = try! db.scalar(accountsTable.count) > 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (hasAccount) {
            
            // Create content and menu controllers
            //
            let homeController = storyboard!.instantiateViewController(withIdentifier: "HomeRoot")
            present(homeController, animated: false, completion: nil)
        } else {
            performSegue(withIdentifier: "ShowSignIn", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

