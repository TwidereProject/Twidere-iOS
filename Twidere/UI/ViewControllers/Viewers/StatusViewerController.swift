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
    
    var status: Status!
    var cellDisplayOption = StatusCell.DisplayOption()
    
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
    
}
