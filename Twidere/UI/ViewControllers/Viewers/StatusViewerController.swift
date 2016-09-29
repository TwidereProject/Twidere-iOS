//
//  StatusViewerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

typealias StatusInfo = (accountKey: UserKey, id: String)

class StatusViewerController: UITableViewController {
    
    private var status: Status!
    private var conversation: [Status]!
    private var statusInfo: StatusInfo!
    var cellDisplayOption = StatusCell.DisplayOption()
    private var itemCounts: [Int] = [Int](repeating: 0, count: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cellDisplayOption = StatusCell.DisplayOption()
        self.cellDisplayOption.fontSize = 15
        
        tableView.register(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "Status")
        tableView.register(UINib(nibName: "GapCell", bundle: nil), forCellReuseIdentifier: "Gap")
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMore")
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statusCell = tableView.dequeueReusableCell(withIdentifier: "DetailStatus", for: indexPath) as! DetailStatusCell
        statusCell.displayOption = self.cellDisplayOption
        return statusCell
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
        return tableView.fd_heightForCell(withIdentifier: "DetailStatus", cacheBy: indexPath) { cell in
            let statusCell = cell as! DetailStatusCell
            statusCell.displayOption = self.cellDisplayOption
            statusCell.display(self.status)
        }
    }
    
    func displayStatus(_ status: Status) {
        self.status = status
    }
    
    func rebuildIndices() {
        
    }
    
}
