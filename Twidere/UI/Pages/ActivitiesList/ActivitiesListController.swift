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

class ActivitiesListController: UITableViewController {
    
    var activities: [Activity]! {
        didSet {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.activities[indexPath.item].action! {
        case .mention, .reply, .quote:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath) as! StatusCell
            cell.displayOption = cellDisplayOption
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Activity", for: indexPath) as! ActivityTitleSummaryCell
            cell.displayOption = cellDisplayOption
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch cell {
        case let cell as ActivityTitleSummaryCell:
            cell.displayActivity(self.activities[indexPath.item])
        case let cell as StatusCell:
            cell.status = self.activities[indexPath.item].activityStatus
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.activities[indexPath.item].action! {
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
                cell.displayActivity(self.activities[indexPath.item])
            }
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
