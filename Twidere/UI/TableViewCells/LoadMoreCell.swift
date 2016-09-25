//
//  LoadMoreCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/25.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class LoadMoreCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
