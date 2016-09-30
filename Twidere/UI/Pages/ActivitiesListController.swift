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
    
    var cellDisplayOption: StatusCell.DisplayOption!
        
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
        refreshControl = control
        
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
        _ = DispatchQueue.global().promise { () -> Account in
            return try defaultAccount()!
        }.then { account -> Promise<[Activity]> in
            let paging = Paging()
            return account.newMicroBlogService().getActivitiesAboutMe(paging: paging)
        }.then { activities in
            self.activities = activities
        }.catch { error in
            print(error)
        }.always {
            self.refreshControl?.endRefreshing()
        }
    }
}
