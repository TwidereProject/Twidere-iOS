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

class StatusesListController: UITableViewController, StatusCellDelegate, PullToRefreshProtocol, UIViewControllerPreviewingDelegate {
    
    var statuses: [Status]? = nil {
        didSet {
            self.rebuildItemCounts()
            self.tableView?.reloadData()
        }
    }
    
    var refreshEnabled: Bool = true {
        didSet {
            refreshControl?.isEnabled = refreshEnabled
        }
    }
    
    var loadMoreEnabled: Bool = true
    
    var dataSource: StatusesListControllerDataSource!
    var delegate: StatusesListControllerDelegate!
    var scrollDelegate: UIScrollViewDelegate!
    
    var cellDisplayOption: StatusCell.DisplayOption!
    
    private var firstRefreshShowed: Bool = false
    private var refreshTaskRunning: Bool = false
    private var itemCounts: ItemIndices = ItemIndices(2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.loadUserDefaults()
        
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.register(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMore")
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refreshFromStart), for: .valueChanged)
        self.refreshControl = control
        
        self.refreshControl?.isEnabled = self.refreshEnabled
        
        statuses = nil
        let opts = LoadOptions()
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: self.dataSource.getAccounts())
        self.loadStatuses(opts)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        registerForPreviewing(with: self, sourceView: tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!firstRefreshShowed && self.refreshEnabled) {
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.contentOffset = CGPoint(x: 0, y: -self.refreshControl!.frame.size.height)
                self.refreshControl!.beginRefreshing()
                }, completion: { _ in
                    if (self.statuses != nil) {
                        self.refreshControl!.endRefreshing()
                    }
            })
            self.firstRefreshShowed = true
        }
    }
    
    func willEnterForeground() {
        let opts = LoadOptions()
        
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: dataSource.getAccounts())
        
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
        return itemCounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let status = statuses![(indexPath as NSIndexPath).item]
            if (statuses!.endIndex != indexPath.item && status.isGap ?? false) {
                return tableView.dequeueReusableCell(withIdentifier: "Gap", for: indexPath)
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusCell
                cell.displayOption = self.cellDisplayOption
                cell.delegate = self
                return cell
            }
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMore", for: indexPath)
            cell.selectionStyle = .none
            return cell
        default: abort()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as StatusCell:
            cell.status = statuses![(indexPath as NSIndexPath).item]
        case let cell as LoadMoreCell:
            cell.startAnimating()
            guard let lastStatus = statuses?.last else {
                return
            }
            let accounts = dataSource.getAccounts()
            if (!self.refreshTaskRunning) {
                if let accountKey = accounts.filter({$0.key == lastStatus.accountKey}).first {
                    let opts = LoadOptions()
                    let params = SimpleRefreshTaskParam(accounts: [accountKey])
                    params.maxIds = [lastStatus.id]
                    params.maxSortIds = [lastStatus.sortId ?? -1]
                    params.isLoadingMore = true
                    opts.initLoad = false
                    opts.params = params
                    loadStatuses(opts)
                }
            }
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let status = statuses![(indexPath as NSIndexPath).item]
            if (statuses!.endIndex != indexPath.item && status.isGap ?? false) {
                return super.tableView(tableView, heightForRowAt: indexPath)
            } else {
                return tableView.fd_heightForCell(withIdentifier: "Status", cacheBy: indexPath) { cell in
                    let statusCell = cell as! StatusCell
                    statusCell.displayOption = self.cellDisplayOption
                    statusCell.status = status
                }
            }
        case 1:
            return super.tableView(tableView, heightForRowAt: indexPath)
        default:
            abort()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let status = statuses![(indexPath as NSIndexPath).item]
            let accounts = dataSource.getAccounts()
            if (status.isGap ?? false) {
                if let accountKey = accounts.filter({$0.key == status.accountKey}).first {
                    let opts = LoadOptions()
                    let params = SimpleRefreshTaskParam(accounts: [accountKey])
                    params.maxIds = [status.id]
                    params.maxSortIds = [status.sortId ?? -1]
                    params.isLoadingMore = true
                    opts.initLoad = false
                    opts.params = params
                    loadStatuses(opts)
                }
            } else {
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                vc.displayStatus(status)
                navigationController?.show(vc, sender: self)
            }
        case 1:
            break
        default:
            abort()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let status = statuses![(indexPath as NSIndexPath).item]
            if (status.isGap != true) {
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                previewingContext.sourceRect = cell.frame
                vc.displayStatus(status)
                return vc
            }
        default:
            break
        }
        return nil
    }
    
    @available(iOS 9.0, *)
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        self.show(viewControllerToCommit, sender: self)
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
        
        opts.params = RefreshFromStartParam(accounts: dataSource.getAccounts(), dataSource!)
        loadStatuses(opts)
    }
    
    func profileImageTapped(status: Status) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
        vc.loadUser(userInfo: (status.accountKey, status.userKey, status.userScreenName))
        navigationController?.show(vc, sender: self)
    }
    
    fileprivate func loadStatuses(_ opts: LoadOptions) {
        self.refreshTaskRunning = true
        if let promise = dataSource?.loadStatuses(opts) {
            promise.then { statuses in
                self.statuses = statuses
                }.always {
                    self.refreshControl?.endRefreshing()
                    self.delegate?.refreshEnded()
                    self.refreshTaskRunning = false
                }.catch { error in
                    // TODO show error
                    debugPrint(error)
            }
        }
    }
    
    fileprivate func rebuildItemCounts() {
        if let statuses = self.statuses, !statuses.isEmpty {
            itemCounts[0] = statuses.count
            itemCounts[1] = self.loadMoreEnabled ? 1 : 0
        } else {
            itemCounts[0] = 0
            itemCounts[1] = 0
        }
    }
    
    class LoadOptions {
        
        var initLoad: Bool = false
        
        var params: RefreshTaskParam? = nil
    }
    
    class RefreshFromStartParam: RefreshTaskParam {
        var accounts: [Account]
        var delegate: StatusesListControllerDataSource
        
        init(accounts: [Account], _ delegate: StatusesListControllerDataSource) {
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

protocol StatusesListControllerDataSource {
    
    func getAccounts() -> [Account]
    
    func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[Status]>
    
    func getNewestStatusIds(_ accounts: [Account]) -> [String?]?
    
    func getNewestStatusSortIds(_ accounts: [Account]) -> [Int64]?
 
}

protocol StatusesListControllerDelegate {
    func refreshEnded()
}
