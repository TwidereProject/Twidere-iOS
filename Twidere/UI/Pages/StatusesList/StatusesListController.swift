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
    var scrollDelegate: UIScrollViewDelegate!
    
    var cellDisplayOption: StatusCell.DisplayOption!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.fontSize = 15
        
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.register(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        
        if (delegate.refreshEnabled) {
            if (self.refreshControl == nil) {
                let control = UIRefreshControl()
                control.addTarget(self, action: #selector(self.refreshFromStart), for: .valueChanged)
                refreshControl = control
            }
        } else {
            refreshControl = nil
        }
        
        statuses = nil
        
        
        self.refreshControl?.beginRefreshingManually()
        
        let opts = LoadOptions()
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: self.delegate.getAccounts())
        self.loadStatuses(opts)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewWillAppear")
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let status = statuses![(indexPath as NSIndexPath).item]
        if (statuses!.endIndex != (indexPath as NSIndexPath).item && status.isGap ?? false) {
            return tableView.dequeueReusableCell(withIdentifier: "Gap", for: indexPath)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusCell
            cell.displayOption = self.cellDisplayOption
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case is StatusCell:
            (cell as! StatusCell).status = statuses![(indexPath as NSIndexPath).item]
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let status = statuses![(indexPath as NSIndexPath).item]
        if (status.isGap ?? false) {
            return super.tableView(tableView, heightForRowAt: indexPath)
        } else {
            return tableView.fd_heightForCell(withIdentifier: "Status", cacheBy: indexPath) { cell in
                let statusCell = cell as! StatusCell
                statusCell.displayOption = self.cellDisplayOption
                statusCell.status = status
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let status = statuses![(indexPath as NSIndexPath).item]
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
            let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
            vc.status = status
            navigationController?.show(vc, sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: ScrollView delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
        self.scrollDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
        self.scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = false
        self.scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            AppDelegate.performingScroll = false
        }
        self.scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    func refreshFromStart() {
        let opts = LoadOptions()
        opts.initLoad = false
        
        opts.params = RefreshFromStartParam(accounts: delegate.getAccounts(), delegate!)
        loadStatuses(opts)
    }
    
    fileprivate func loadStatuses(_ opts: LoadOptions) {
        if let promise = delegate?.loadStatuses(opts) {
            promise.then { statuses in
                self.statuses = statuses
                }.always {
                    self.refreshControl?.endRefreshing()
                }.catch { error in
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
    
    var refreshEnabled: Bool {
        get
    }
    
    func getAccounts() -> [Account]
    
    func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[Status]>
    
    func getNewestStatusIds(_ accounts: [Account]) -> [String?]?
    
    func getNewestStatusSortIds(_ accounts: [Account]) -> [Int64]?
    
}
