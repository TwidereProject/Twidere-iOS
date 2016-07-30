//
//  AccountsManagerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/17.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import PromiseKit
import SugarRecord

class AccountsManagerController: UITableViewController {

    var accounts: [Account]? = nil
    
    override func viewDidLoad() {
        dispatch_promise { () -> [Account] in
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStorage
            return try! db.fetch(Request<Account>())
        }.then { accounts  in
            self.accounts = accounts
        }.always { 
            self.tableView.reloadData()
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AccountItem", forIndexPath: indexPath)
        cell.textLabel?.text = accounts?[indexPath.item].user?.name
        return cell
    }
    
    @IBAction func closeAcccountsManager(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}