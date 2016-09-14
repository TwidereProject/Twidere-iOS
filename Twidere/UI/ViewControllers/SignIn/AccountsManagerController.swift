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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "AccountItem", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! AccountCell).display(accounts![(indexPath as NSIndexPath).item])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
        
    @IBAction func closeAcccountsManager(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
