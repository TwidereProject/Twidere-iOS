//
//  ActivityTitleSummaryCell.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import ALSLayouts
import YYText

class ActivityTitleSummaryCell: ALSTableViewCell {

    @IBOutlet weak var timeView: ShortTimeView!
    @IBOutlet weak var titleView: YYLabel!
    @IBOutlet weak var summaryView: YYLabel!
    @IBOutlet weak var profileImagesContainer: UIStackView!
    
    var displayOption: StatusCell.DisplayOption! {
        didSet {
            timeView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.85)
            
            titleView.font = UIFont.systemFont(ofSize: displayOption.fontSize)
            summaryView.font = UIFont.systemFont(ofSize: displayOption.fontSize * 0.9)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        for view in profileImagesContainer.subviews {
            let view = view as! UIImageView
            view.contentMode = .scaleAspectFill
            view.makeCircular()
        }
    }

    func displayActivity(_ activity: Activity) {
        let (title, summary) = activity.getTitleSummary()
        titleView.text = title
        summaryView.text = summary
        summaryView.layoutParams.hidden = summary?.isEmpty ?? true
        timeView.time = activity.createdAt
        
        let profileImageViews = profileImagesContainer.subviews
        for profileImageIdx in 0..<profileImageViews.count {
            let view = profileImageViews[profileImageIdx] as! UIImageView
            if (profileImageIdx < activity.sources.count) {
                view.displayImage(activity.sources[profileImageIdx].profileImageUrlForSize(.reasonablySmall))
            } else {
                view.displayImage(nil)
            }
        }
    }
    
}
