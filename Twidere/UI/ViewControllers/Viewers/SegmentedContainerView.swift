//
//  UserPagesScrollView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import MXParallaxHeader

class SegmentedContainerView: UIView {

    var dataSource: SegmentedContainerViewDataSource!
    
    var contentView: MXScrollView
    var segmentControl: UISegmentedControl
    
    required init?(coder aDecoder: NSCoder) {
        self.contentView = MXScrollView()
        self.segmentControl = UISegmentedControl()

        super.init(coder: aDecoder)
        
        self.addSubview(self.contentView)
        contentView.addSubview(self.segmentControl)
    }
    
    override func layoutSubviews() {
        // Layout content view
        var frame = self.bounds;
        
        // Set origin to (0, 0)
        frame.origin = CGPoint.zero
        self.contentView.frame = frame
        self.contentView.contentSize = self.contentView.frame.size
        self.contentView.isScrollEnabled = self.contentView.parallaxHeader.view != nil
        self.contentView.contentInset = UIEdgeInsetsMake(self.contentView.parallaxHeader.height, 0, 0, 0)
        
        
        frame = contentView.bounds
        
        // Set origin to (0, 0)
        frame.insetBy(dx: 16, dy: 16)
        
        frame.size = segmentControl.sizeThatFits(frame.size)
        
        segmentControl.frame = frame
    }
    
    func reloadData() {
        let count = dataSource.numberOfViewControllers(in: self)
        
        segmentControl.removeAllSegments()
        
        for idx in 0..<count {
            let title = dataSource.segmentedContainer(self, titleAt: idx)
            segmentControl.insertSegment(withTitle: title, at: segmentControl.numberOfSegments, animated: false)
        }
    }
    
}

protocol SegmentedContainerViewDataSource {
    
    func numberOfViewControllers(in tableView: SegmentedContainerView) -> Int
    
    func segmentedContainer(_ containerView: SegmentedContainerView, viewControllerAt index: Int) -> UIViewController
    
    func segmentedContainer(_ containerView: SegmentedContainerView, titleAt index: Int) -> String
    
}
