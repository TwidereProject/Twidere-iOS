//
//  StatusesListController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import UITableView_FDTemplateLayoutCell

class StatusesListController: UITableViewController {
    
    var statuses: [FlatStatus]? = nil {
        didSet {
            tableView?.reloadData()
        }
    }
    var delegate: StatusesListControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.registerNib(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.registerNib(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refreshFromStart), forControlEvents: .ValueChanged)
        refreshControl = control
        
        refreshControl?.beginRefreshing()
        let opts = LoadOptions()
        opts.initLoad = true
        loadStatuses(opts)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let status = statuses![indexPath.item]
        if (status.isGap ?? false) {
            let cell = tableView.dequeueReusableCellWithIdentifier("Gap", forIndexPath: indexPath) as! GapCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Status", forIndexPath: indexPath) as! StatusCell
            cell.status = status
            return cell
        }
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let status = statuses![indexPath.item]
        if (status.isGap ?? false) {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        } else {
            return tableView.fd_heightForCellWithIdentifier("Status", cacheByIndexPath: indexPath) { cell in
                (cell as! StatusCell).status = status
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func refreshFromStart() {
        let opts = LoadOptions()
        opts.initLoad = false
        loadStatuses(opts)
    }
    
    private func loadStatuses(opts: LoadOptions) {
        if let promise = delegate?.loadStatuses(opts) {
            promise.then { statuses in
                self.statuses = statuses
            }.always {
                self.refreshControl?.endRefreshing()
            }.error { error in
                // TODO show error
                debugPrint(error)
            }
        }
    }
    
    class LoadOptions {
        
        var initLoad: Bool = false
        
    }
}

protocol StatusesListControllerDelegate {
    
    func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[FlatStatus]>
    
}
