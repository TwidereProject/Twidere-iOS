//
//  StatusesListController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/21.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import PromiseKit
import UITableView_FDTemplateLayoutCell
import YYText
import TwidereCore
import MicroBlog

class StatusesListController: UITableViewController, StatusCellDelegate, PullToRefreshProtocol, UIViewControllerPreviewingDelegate {
    
    var statuses: [PersistableStatus]? = nil {
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
            if (statuses!.endIndex != indexPath.item && status.is_gap) {
                return tableView.dequeueReusableCell(withIdentifier: "Gap", for: indexPath)
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusCell
                cell.delegate = self
                cell.displayOption = self.cellDisplayOption
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
                    params.maxSortIds = [lastStatus.sortId]
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
            if (statuses!.endIndex != indexPath.item && status.is_gap) {
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
            if (status.is_gap) {
                let accounts = dataSource.getAccounts()
                if let account = accounts.filter({$0.key == status.accountKey}).first {
                    let opts = LoadOptions()
                    let params = SimpleRefreshTaskParam(accounts: [account])
                    params.maxIds = [status.id]
                    params.maxSortIds = [status.sortId]
                    params.isLoadingMore = true
                    opts.initLoad = false
                    opts.params = params
                    loadStatuses(opts)
                }
            } else {
                let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
                vc.displayStatus(status)
//                navigationController?.show(vc, sender: self)
                self.show(vc, sender: self)
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
        switch cell {
        case let cell as StatusCell:
            let (vc, rect, present) = cell.previewViewController(for: tableView.convert(location, to: cell))
            previewingContext.sourceRect = cell.convert(rect, to: tableView)
            previewingContext.shouldPresentViewController = present
            
            if let svc = vc as? StatusViewerController {
                svc.previewCallback = { status, action in
                    switch action {
                    case .share:
                        self.shareStatus(status: cell.status)
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
            present(viewControllerToCommit, animated: true, completion: nil)
        } else {
            self.show(viewControllerToCommit, sender: self)
        }
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
    
    func profileImageTapped(for cell: StatusCellProtocol, status: PersistableStatus) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
        vc.displayUser(user: status.user, reload: true)
        self.show(vc, sender: self)
    }
    
    func spanItemTapped(for cell: StatusCellProtocol, status: PersistableStatus, span: SpanItem) {
        guard let (vc, present) = span.createViewController(accountKey: status.accountKey) else {
            return
        }
        if (present) {
            self.present(vc, animated: true, completion: nil)
        } else {
            self.show(vc, sender: self)
        }
    }
    
    func quotedViewTapped(for cell: StatusCellProtocol, status: PersistableStatus) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
        vc.displayStatus(status.quotedStatus!, reload: true)
        self.show(vc, sender: self)
    }
    
    func mediaPreviewTapped(for cell: StatusCellProtocol, status: PersistableStatus) {
        let vc = SafariBrowserController(url: URL(string: status.metadata!.media.first!.mediaUrl!)!)
        self.present(vc, animated: true, completion: nil)
    }
    
    func actionSelected(for cell: StatusCellProtocol, status: PersistableStatus, action: StatusCell.StatusAction) {
        switch action {
        case .reply:
            replyStatus(status: status)
        case .retweet:
            showRetweetActions(status: status)
        case .favorite:
            toggleFavoriteStatus(status: status)
        case .more:
            openStatusMenu(status: status)
        default:
            break
        }
    }
    
    func shareStatus(status: PersistableStatus) {
        guard let url = URL(string: status.statusUrl) else {
            return
        }
        let activityItems: [Any] = [
            url,
            status.textPlain
        ]
        let avc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        navigationController?.present(avc, animated: true, completion: nil)
    }
    
    func replyStatus(status: PersistableStatus) {
        guard let nvc = self.navigationController else {
            return
        }
        let cvc = ComposeController.create(inReplyTo: status)
        cvc.show(parent: nvc.parent ?? nvc)
    }
    
    func showRetweetActions(status: PersistableStatus) {
        let ac = UIAlertController(title: "Retweet", message: nil, preferredStyle: .actionSheet)
        let servicePromise = DispatchQueue.global().promise { () -> MicroBlogService in
            let account = getAccount(forKey: status.account_key)!
            return account.newMicroBlogService()
        }
        if (status.metadata?.myRetweetId != nil) {
            ac.addAction(UIAlertAction(title: "Cencel retweet", style: .destructive) { _ in
                servicePromise.then { microBlog -> Promise<PersistableStatus> in
                    return microBlog.unretweetStatus(id: status.id)
                }.showStatusBarNotificationAfterTask(success: "Retweet cancelled", failure: "Unable to cancel retweet")
            })
        } else if (!(status.metadata?.isUserProtected ?? false)) {
            ac.addAction(UIAlertAction(title: "Retweet", style: .default) { _ in
                servicePromise.then { microBlog -> Promise<PersistableStatus> in
                    return microBlog.retweetStatus(id: status.id)
                }.showStatusBarNotificationAfterTask(success: "Retweeted", failure: "Unable to retweet")
            })
        }
        ac.addAction(UIAlertAction(title: "Quote", style: .default) { _ in
            
        })
        ac.addAction(UIAlertAction(title: "RT tweet", style: .default) { _ in
            guard let nvc = self.navigationController else {
                return
            }
            let vc = ComposeController.create(inReplyTo: status)
            vc.originalText = "RT @\(status.userScreenName): \(status.textPlain)"
            vc.show(parent: nvc.parent ?? nvc)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func toggleFavoriteStatus(status: PersistableStatus) {
        guard let accountKey = status.account_key else {
            return
        }
        let isFavorite = status.is_favorite
        let servicePromise = DispatchQueue.global().promise { () -> FavoritesAPI in
            let account = getAccount(forKey: accountKey)!
            return account.newMicroBlogService()
        }
        if (isFavorite) {
            servicePromise.then { microBlog -> Promise<PersistableStatus> in
                return microBlog.destroyFavorite(id: status.id)
            }.showStatusBarNotificationAfterTask(success: "Tweet unfavorited", failure: "Unable to unfavorite tweet")
        } else {
            servicePromise.then { microBlog -> Promise<PersistableStatus> in
                return microBlog.createFavorite(id: status.id)
            }.showStatusBarNotificationAfterTask(success: "Tweet favorited", failure: "Unable to favorite tweet")
        }
    }
    
    func confirmAndDestroyStatus(status: PersistableStatus) {
        
    }
    
    func openStatusMenu(status: PersistableStatus) {
        let ac = UIAlertController(title: "Tweet", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Share", style: .default) { _ in
            self.shareStatus(status: status)
        })
        if (status.account_key == status.user_key) {
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                self.confirmAndDestroyStatus(status: status)
            })
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    fileprivate func loadStatuses(_ opts: LoadOptions) {
        self.refreshTaskRunning = true
        dataSource?.loadStatuses(opts).then { statuses -> Void in
            self.statuses = statuses
            self.dataSource?.statuses = statuses
        }.always {
            self.refreshControl?.endRefreshing()
            self.delegate?.refreshEnded()
            self.refreshTaskRunning = false
        }.catch { error in
            // TODO show error
            debugPrint(error)
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
        
        var loadItemLimit: Int = 20
        
        var params: RefreshTaskParam? = nil
    }
    
    class RefreshFromStartParam: RefreshTaskParam {
        var accounts: [AccountDetails]
        var delegate: StatusesListControllerDataSource
        
        init(accounts: [AccountDetails], _ delegate: StatusesListControllerDataSource) {
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
    
    var statuses: [PersistableStatus]? { get set }
    
    func getAccounts() -> [AccountDetails]
    
    func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[PersistableStatus]>
    
    func getNewestStatusIds(_ accounts: [AccountDetails]) -> [String?]?
    
    func getNewestStatusSortIds(_ accounts: [AccountDetails]) -> [Int64]?
 
}

protocol StatusesListControllerDelegate {
    func refreshEnded()
}
