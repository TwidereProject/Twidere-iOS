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

class StatusViewerController: UITableViewController {
    
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
    var cellDisplayOption: StatusCell.DisplayOption! = StatusCell.DisplayOption()
    private var itemIndices: ItemIndices = ItemIndices(1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.fontSize = 15
        
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
            items.append(UIPreviewAction(title: "Reply", style: .default, handler: {_,_ in }))
            items.append(UIPreviewAction(title: "Retweet", style: .default, handler: {_,_ in }))
            items.append(UIPreviewAction(title: "Favorite", style: .default, handler: {_,_ in }))
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
    
    func rebuildIndices() {
        if (self.status != nil) {
            itemIndices[0] = 1
        } else {
            itemIndices[0] = 0
        }
    }
    
}
