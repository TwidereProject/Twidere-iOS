//
//  StatusViewerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import UITableView_FDTemplateLayoutCell

class StatusViewerController: UITableViewController {
    
    var status: FlatStatus!
    var cellDisplayOption = StatusCell.DisplayOption()
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let statusCell = tableView.dequeueReusableCellWithIdentifier("DetailStatus", forIndexPath: indexPath) as! DetailStatusCell
        statusCell.displayOption = self.cellDisplayOption
        return statusCell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case is DetailStatusCell:
            let statusCell = cell as! DetailStatusCell
            statusCell.display(status)
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableView.fd_heightForCellWithIdentifier("DetailStatus", cacheByIndexPath: indexPath) { cell in
            let statusCell = cell as! DetailStatusCell
            statusCell.displayOption = self.cellDisplayOption
            statusCell.display(self.status)
        }
    }
    
}