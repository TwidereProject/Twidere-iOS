//
//  StatusViewerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell
import PromiseKit

typealias StatusInfo = (accountKey: UserKey, id: String)
typealias StatusPreviewCallback = (_ status: Status, _ action: StatusViewerController.PreviewAction) -> Void

class StatusViewerController: UITableViewController, DetailStatusCellDelegate {
    
    var cellDisplayOption: StatusCell.DisplayOption! = StatusCell.DisplayOption()
    var previewCallback: StatusPreviewCallback!
    
    private var status: Status! {
        didSet {
            rebuildIndices()
        }
    }
    private var statusInfo: StatusInfo! {
        didSet {
            rebuildIndices()
        }
    }
    private var reloadNeeded: Bool = false
    
    private var conversation: [Status]!
    private var itemIndices: ItemIndices = ItemIndices(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.loadUserDefaults()
        
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.register(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMore")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        if (self.status != nil) {
            tableView.reloadData()
            if (self.reloadNeeded) {
                self.loadStatus()
            }
        } else if (self.statusInfo != nil) {
            loadStatus()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemIndices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch itemIndices.getItemCountIndex(position: indexPath.item) {
        case 0:
            let statusCell = tableView.dequeueReusableCell(withIdentifier: "DetailStatus", for: indexPath) as! DetailStatusCell
            statusCell.displayOption = self.cellDisplayOption
            statusCell.delegate = self
            return statusCell
        default:
            break
        }
        abort()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case is DetailStatusCell:
            let statusCell = cell as! DetailStatusCell
            statusCell.display(status)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch itemIndices.getItemCountIndex(position: indexPath.item) {
        case 0:
            return tableView.fd_heightForCell(withIdentifier: "DetailStatus", cacheBy: indexPath) { cell in
                let statusCell = cell as! DetailStatusCell
                statusCell.displayOption = self.cellDisplayOption
                statusCell.display(self.status)
            }
        default:
            break
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        var items: [UIPreviewActionItem] = []
        if (cellDisplayOption.hideActions) {
            items.append(UIPreviewAction(title: "Reply", style: .default, handler: {_,_ in self.invokePreviewCallback(.reply) }))
            items.append(UIPreviewAction(title: "Retweet", style: .default, handler: {_,_ in self.invokePreviewCallback(.retweet) }))
            items.append(UIPreviewAction(title: "Favorite", style: .default, handler: {_,_ in self.invokePreviewCallback(.favorite) }))
        }
        items.append(UIPreviewAction(title: "Share…", style: .default, handler: {_,_ in self.invokePreviewCallback(.share) }))
        if let status = self.status {
            if (status.accountKey == status.userKey) {
                items.append(UIPreviewAction(title: "Delete", style: .destructive, handler: {_,_ in self.invokePreviewCallback(.destroy) }))
            }
        }
        return items
    }
    
    func displayStatus(_ status: Status, reload: Bool = false) {
        self.status = status
        self.statusInfo = (status.accountKey, status.id)
        if (self.isViewLoaded) {
            self.tableView.reloadData()
        }
        self.reloadNeeded = reload
        if (reload) {
            self.loadStatus(statusInfo: self.statusInfo)
        }
    }
    
    
    func loadStatus(statusInfo: StatusInfo) {
        self.statusInfo = statusInfo
        if (self.isViewLoaded) {
            self.loadStatus()
        }
    }
    
    fileprivate func invokePreviewCallback(_ action: PreviewAction) {
        guard let status = self.status else {
            return
        }
        previewCallback?(status, action)
    }
    
    fileprivate func shareStatus(status: Status) {
        guard let status = self.status, let url = URL(string: status.statusUrl) else {
            return
        }
        let activityItems: [Any] = [
            url,
            status.textPlain
        ]
        let avc = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        navigationController?.present(avc, animated: true, completion: nil)
    }
    
    
    fileprivate func loadStatus() {
        guard let statusInfo = self.statusInfo else {
            return
        }
        self.reloadNeeded = false
        _ = DispatchQueue.global().promise { () -> Account in
            return getAccount(forKey: statusInfo.accountKey)!
        }.then { account -> Promise<Status> in
            let api = account.newMicroBlogService()
            return api.showStatus(id: statusInfo.id)
        }.then { status -> Void in
            self.status = status
            self.tableView.reloadData()
        }
    }
    
    func actionSelected(for cell: StatusCellProtocol, status: Status, action: StatusCell.StatusAction) {
        switch action {
        case .reply:
            replyStatus(status: status)
        case .favorite:
            toggleFavoriteStatus(status: status)
        case .share:
            shareStatus(status: status)
        default:
            break
        }
    }
    
    func profileImageTapped(for cell: StatusCellProtocol, status: Status) {
        
    }
    
    func quotedViewTapped(for cell: StatusCellProtocol, status: Status) {
        let storyboard = UIStoryboard(name: "Viewers", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StatusDetails") as! StatusViewerController
        vc.displayStatus(status.quotedStatus!, reload: true)
        self.show(vc, sender: self)
    }
    
    func mediaPreviewTapped(for cell: StatusCellProtocol, status: Status) {
        
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
    
    func replyStatus(status: Status) {
        guard let nvc = self.navigationController else {
            return
        }
        let cvc = ComposeController.create()
        cvc.inReplyToStatus = status
        cvc.show(parent: nvc.parent ?? nvc)
    }
    
    func toggleFavoriteStatus(status: Status) {
        guard let accountKey = status.accountKey, let isFavorite = status.metadata?.isFavorite else {
            return
        }
        let servicePromise = DispatchQueue.global().promise { () -> MicroBlogService in
            let account = getAccount(forKey: accountKey)!
            return account.newMicroBlogService()
        }
        if (isFavorite) {
            servicePromise.then { microBlog -> Promise<Status> in
                return microBlog.destroyFavorite(id: status.id)
                }.showStatusBarNotificationAfterTask(success: "Tweet unfavorited", failure: "Unable to unfavorite tweet")
        } else {
            servicePromise.then { microBlog -> Promise<Status> in
                return microBlog.createFavorite(id: status.id)
                }.showStatusBarNotificationAfterTask(success: "Tweet favorited", failure: "Unable to favorite tweet")
        }
    }
    
    func rebuildIndices() {
        if (self.status != nil) {
            itemIndices[0] = 1
        } else {
            itemIndices[0] = 0
        }
    }
 
    enum PreviewAction {
        case reply, retweet, favorite, share, destroy
    }
}
