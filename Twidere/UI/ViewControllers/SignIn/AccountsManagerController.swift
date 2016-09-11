//
//  AccountsManagerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/17.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import PromiseKit

class AccountsManagerController: UITableViewController {

    var accounts: [Account]? = nil
    
    override func viewDidLoad() {
        dispatch_promise { () -> [Account] in
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
            return try! db.prepare(accountsTable).map{ Account(row: $0) }
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
        return tableView.dequeueReusableCellWithIdentifier("AccountItem", forIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! AccountCell).display(accounts![indexPath.item])
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
        
    @IBAction func closeAcccountsManager(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}