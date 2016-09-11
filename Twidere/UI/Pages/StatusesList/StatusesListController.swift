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
    
    var statuses: [Status]? = nil {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var delegate: StatusesListControllerDelegate!
    var cellDisplayOption: StatusCell.DisplayOption!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.fontSize = 15

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
        opts.params = SimpleRefreshTaskParam(accounts: delegate.getAccounts())
        
        loadStatuses(opts)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willEnterForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func willEnterForeground() {
        let opts = LoadOptions()
        
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: delegate.getAccounts())
        
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
        if (statuses!.endIndex != indexPath.item && status.isGap ?? false) {
            return tableView.dequeueReusableCellWithIdentifier("Gap", forIndexPath: indexPath)
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("Status", forIndexPath: indexPath) as! StatusCell
            cell.displayOption = self.cellDisplayOption
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case is StatusCell:
            (cell as! StatusCell).status = statuses![indexPath.item]
        default: break
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let status = statuses![indexPath.item]
        if (status.isGap ?? false) {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        } else {
            return tableView.fd_heightForCellWithIdentifier("Status", cacheByIndexPath: indexPath) { cell in
                let statusCell = cell as! StatusCell
                statusCell.displayOption = self.cellDisplayOption
                statusCell.status = status
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let status = statuses![indexPath.item]
        let accounts = delegate.getAccounts()
        if (status.isGap ?? false) {
            guard let accountKey = accounts.filter({$0.key == status.accountKey}).first else {
                return
            }
            let opts = LoadOptions()
            let params = SimpleRefreshTaskParam(accounts: [accountKey])
            params.maxIds = [status.id]
            params.maxSortIds = [status.sortId ?? -1]
            params.isLoadingMore = true
            opts.initLoad = false
            opts.params = params
            loadStatuses(opts)
        } else {
            let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("StatusDetails") as! StatusViewerController
            vc.status = status
            navigationController?.showViewController(vc, sender: self)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        AppDelegate.performingScroll = false
    }
    
    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            AppDelegate.performingScroll = false
        }
    }
    
    func refreshFromStart() {
        let opts = LoadOptions()
        opts.initLoad = false
        
        opts.params = RefreshFromStartParam(accounts: delegate.getAccounts(), delegate!)
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
        
        var params: RefreshTaskParam? = nil
    }
    
    class RefreshFromStartParam: RefreshTaskParam {
        var accounts: [Account]
        var delegate: StatusesListControllerDelegate
        
        init(accounts: [Account], _ delegate: StatusesListControllerDelegate) {
            self.accounts = accounts
            self.delegate = delegate
        }
        
        var sinceIds: [String?]? {
            return delegate.getNewestStatusIds(accounts)
        }
        
        var sinceSortIds: [Int64]? {
            return delegate.getNewestStatusSortIds(accounts)
        }

    }
}

protocol StatusesListControllerDelegate {
    
    func getAccounts() -> [Account]
    
    func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[Status]>
    
    func getNewestStatusIds(accounts: [Account]) -> [String?]?
    
    func getNewestStatusSortIds(accounts: [Account]) -> [Int64]?
    
}
