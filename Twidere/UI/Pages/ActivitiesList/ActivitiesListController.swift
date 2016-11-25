//
//  ActivitiesListController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import PromiseKit
import UITableView_FDTemplateLayoutCell

class ActivitiesListController: UITableViewController, StatusCellDelegate, PullToRefreshProtocol {
    
    var activities: [Activity]! {
        didSet {
            self.rebuildItemCounts()
            self.tableView.reloadData()
        }
    }
    
    var refreshEnabled: Bool = true {
        didSet {
            refreshControl?.isEnabled = refreshEnabled
        }
    }
    
    var loadMoreEnabled: Bool = true
    
    var cellDisplayOption: StatusCell.DisplayOption!
    var dataSource: ActivitiesListControllerDataSource!
    var delegate: ActivitiesListControllerDelegate!
    
    private var firstRefreshShowed: Bool = false
    private var refreshTaskRunning: Bool = false
    private var itemCounts: ItemIndices = ItemIndices(2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.loadUserDefaults()
        
        tableView.register(UINib(nibName: "ActivityTitleSummaryCell", bundle: nil), forCellReuseIdentifier: "Activity")
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.register(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMore")
        
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(self.refreshFromStart), for: .valueChanged)
        self.refreshControl = control
        
        self.refreshControl?.isEnabled = self.refreshEnabled
        
        activities = nil
        let opts = LoadOptions()
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: self.dataSource.getAccounts())
        self.loadActivities(opts)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }

    func willEnterForeground() {
        let opts = LoadOptions()
        
        opts.initLoad = true
        opts.params = SimpleRefreshTaskParam(accounts: dataSource.getAccounts())
        
        loadActivities(opts)
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
            let activity = self.activities[indexPath.item]
            if (activities!.endIndex != indexPath.item && activity.isGap) {
                return tableView.dequeueReusableCell(withIdentifier: "Gap", for: indexPath)
            } else {
                switch activity.action {
                case .mention, .reply, .quote:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusCell
                    cell.delegate = self
                    cell.displayOption = cellDisplayOption
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Activity", for: indexPath) as! ActivityTitleSummaryCell
                    cell.displayOption = cellDisplayOption
                    return cell
                }
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
        case let cell as ActivityTitleSummaryCell:
            cell.activity = self.activities[indexPath.item]
            cell.display()
        case let cell as StatusCell:
            cell.status = self.activities[indexPath.item].activityStatus
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let activity = self.activities[indexPath.item]
            if (activities!.endIndex != indexPath.item && activity.isGap) {
                return super.tableView(tableView, heightForRowAt: indexPath)
            } else {
                switch activity.action {
                case .mention, .reply, .quote:
                    return tableView.fd_heightForCell(withIdentifier: "Status", cacheBy: indexPath) { cell in
                        let cell = (cell as! StatusCell)
                        cell.displayOption = self.cellDisplayOption
                        cell.status = self.activities[indexPath.item].activityStatus
                    }
                default:
                    return tableView.fd_heightForCell(withIdentifier: "Activity", cacheBy: indexPath) { cell in
                        let cell = (cell as! ActivityTitleSummaryCell)
                        cell.displayOption = self.cellDisplayOption
                        cell.activity = self.activities[indexPath.item]
                        cell.display()
                    }
                }
            }
        case 1:
            return super.tableView(tableView, heightForRowAt: indexPath)
        default:
            abort()
        }
    }
    
    // MARK: ScrollView delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
//        self.scrollDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = true
//        self.scrollDelegate?.scrollViewWillBeginDragging?(scrollView)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        AppDelegate.performingScroll = false
//        self.scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            AppDelegate.performingScroll = false
        }
//        self.scrollDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch itemCounts.getItemCountIndex(position: indexPath.item) {
        case 0:
            let activity = activities![(indexPath as NSIndexPath).item]
            if (activity.isGap) {
                guard let account = dataSource.getAccounts().first(where: {$0.key == activity.accountKey}) else {
                    return
                }
                let maxId = activity.minPosition
                let maxSortId = activity.minSortPosition
                let param = SimpleRefreshTaskParam(accounts: [account])
                param.maxIds = [maxId]
                param.maxSortIds = [maxSortId]
                param.isLoadingMore = true
                
                let opts = LoadOptions()
                opts.initLoad = false
                opts.params = param
                loadActivities(opts)
            } else if let status = activity.activityStatus {
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                vc.displayStatus(status)
                self.show(vc, sender: self)
            }
        case 1:
            break
        default:
            abort()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func profileImageTapped(for cell: StatusCellProtocol, status: Status) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
        vc.displayUser(user: status.user, reload: true)
        self.show(vc, sender: self)
    }
    
    func quotedViewTapped(for cell: StatusCellProtocol, status: Status) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
        vc.displayStatus(status.quotedStatus!, reload: true)
        self.show(vc, sender: self)
    }
    
    func mediaPreviewTapped(for cell: StatusCellProtocol, status: Status) {
        let vc = SafariBrowserController(url: URL(string: status.metadata!.media.first!.mediaUrl!)!)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func spanItemTapped(for cell: StatusCellProtocol, status: Status, span: SpanItem) {
        guard let (vc, present) = span.createViewController(accountKey: status.accountKey) else {
            return
        }
        if (present) {
            self.present(vc, animated: true, completion: nil)
        } else {
            self.show(vc, sender: self)
        }
    }
    
    func actionSelected(for cell: StatusCellProtocol, status: Status, action: StatusCell.StatusAction) {
        
    }
    
    @available(iOS 9.0, *)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: location), let cell = tableView.cellForRow(at: indexPath) else {
            return nil
        }
        switch cell {
        case let cell as StatusCell:
            let (vc, rect, present) = cell.previewViewController(for: tableView.convert(location, to: cell))
            previewingContext.sourceRect = cell.convert(rect, to: tableView)
            previewingContext.shouldPresentViewController = present
            
            if let svc = vc as? StatusViewerController {
                svc.previewCallback = { status, action in
                    switch action {
                    case .share:
                        break
                    default:
                        break
                    }
                }
            }
            return vc
        default:
            break
        }
        return nil
    }
    
    @available(iOS 9.0, *)
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        if (previewingContext.shouldPresentViewController) {
            self.present(viewControllerToCommit, animated: true, completion: nil)
        } else {
            self.show(viewControllerToCommit, sender: self)
        }
    }
    
    func refreshFromStart() {
        let opts = LoadOptions()
        opts.initLoad = false
        
        opts.params = RefreshFromStartParam(dataSource.getAccounts(), dataSource!)
        loadActivities(opts)
    }
    
    fileprivate func loadActivities(_ opts: LoadOptions) {
        self.refreshTaskRunning = true
        if let promise = dataSource?.loadActivities(opts) {
            promise.then { activities in
                self.activities = activities
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
        if let activities = self.activities, !activities.isEmpty {
            itemCounts[0] = activities.count
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
        var dataSource: ActivitiesListControllerDataSource
        
        init(_ accounts: [Account], _ dataSource: ActivitiesListControllerDataSource) {
            self.accounts = accounts
            self.dataSource = dataSource
        }
        
        var sinceIds: [String?]? {
            return dataSource.getNewestActivityMaxPositions(accounts)
        }
        
        var sinceSortIds: [Int64]? {
            return dataSource.getNewestActivityMaxSortPositions(accounts)
        }
        
    }
}

protocol ActivitiesListControllerDataSource {
    
    func getAccounts() -> [Account]
    
    func loadActivities(_ opts: ActivitiesListController.LoadOptions) -> Promise<[Activity]>
    
    func getNewestActivityMaxPositions(_ accounts: [Account]) -> [String?]?
    
    func getNewestActivityMaxSortPositions(_ accounts: [Account]) -> [Int64]?
    
}

protocol ActivitiesListControllerDelegate {
    func refreshEnded()
}
