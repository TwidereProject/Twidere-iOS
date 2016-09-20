//
//  UserPagesScrollView.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import MXParallaxHeader
import MXPagerView

class SegmentedContainerView: UIView, MXPagerViewDataSource {
    
    var dataSource: SegmentedContainerViewDataSource! {
        didSet {
            reloadData()
        }
    }
    
    var delegate: SegmentedContainerViewDelegate! {
        didSet { self.contentView.delegate = delegate }
    }
    
    var contentOffset: CGPoint {
        var offset = self.contentView.contentOffset
        offset.y += self.contentView.contentInset.top
        return offset
    }
    
    var contentDividerColor: UIColor? {
        get { return self.dividerView.backgroundColor }
        set { self.dividerView.backgroundColor = newValue }
    }
    
    var contentDividerSize: CGFloat = 0
    
    private var contentView: MXScrollView
    private var segmentedControl: ReselectUISegmentedControl
    private var dividerView: UIView
    private var pagerView: MXPagerView
    
    var parallaxHeader: MXParallaxHeader {
        return contentView.parallaxHeader
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.contentView = MXScrollView()
        self.segmentedControl = ReselectUISegmentedControl()
        self.dividerView = UIView()
        self.pagerView = MXPagerView()
        
        super.init(coder: aDecoder)
        
        self.addSubview(self.contentView)
        contentView.addSubview(self.pagerView)
        contentView.addSubview(self.segmentedControl)
        contentView.addSubview(self.dividerView)
        
        self.segmentedControl.isEnabled = true
        self.segmentedControl.addTarget(self, action: #selector(self.segmentSelectionChanged), for: .valueChanged)
        self.segmentedControl.reselectAction = self.segmentSectionReselected
        
        self.pagerView.dataSource = self
        self.pagerView.isScrollEnabled = false
    }
    
    override func layoutSubviews() {
        layoutContentView()
        layoutSegmentedControl()
        layoutDividerView()
        layoutViewContainer()
    }
    
    func layoutContentView() {
        
        // Use superview size and set origin to (0, 0)
        var frame = self.bounds
        frame.origin = CGPoint.zero
        
        self.contentView.frame = frame
        self.contentView.contentSize = self.contentView.frame.size
        self.contentView.isScrollEnabled = self.contentView.parallaxHeader.view != nil
        self.contentView.contentInset = UIEdgeInsetsMake(self.contentView.parallaxHeader.height, 0, 0, 0)
    }
    
    func layoutSegmentedControl() {
        var frame = self.bounds
        
        frame.origin.x = 8
        frame.origin.y = 8
        
        frame.size.width -= 8
        frame.size.width -= 8
        frame.size.height = self.segmentedControl.intrinsicContentSize.height
        
        self.segmentedControl.frame = frame
    }
    
    func layoutDividerView() {
        var frame = self.bounds
        
        frame.origin = CGPoint.zero
        
        frame.origin.y = self.segmentedControl.intrinsicContentSize.height
        frame.origin.y += 8
        frame.origin.y += 8
        
        frame.size.height = contentDividerSize
        
        self.dividerView.frame = frame
    }
    
    func layoutViewContainer() {
        var frame = self.bounds
        
        frame.origin = CGPoint.zero
        
        frame.origin.y = contentDividerSize
        frame.origin.y += self.segmentedControl.intrinsicContentSize.height
        frame.origin.y += 8
        frame.origin.y += 8
        
        frame.size.height -= frame.origin.y
        frame.size.height -= self.contentView.parallaxHeader.minimumHeight
        
        self.pagerView.frame = frame
    }
    
    func switchTo(index: Int) {
        pagerView.showPage(at: index, animated: false)
    }
    
    func reloadData() {
        let count = dataSource.numberOfViews(in: self)
        
        segmentedControl.removeAllSegments()
        
        for idx in 0..<count {
            let title = dataSource.segmentedContainer(self, titleFor: idx)
            segmentedControl.insertSegment(withTitle: title, at: segmentedControl.numberOfSegments, animated: false)
        }
        pagerView.reloadData()
        
        let idx = min(max(0, segmentedControl.selectedSegmentIndex), count - 1)
        
        if idx < count {
            switchTo(index: idx)
            segmentedControl.selectedSegmentIndex = idx
        }
    }
    
    func numberOfPages(in pagerView: MXPagerView) -> Int {
        return dataSource.numberOfViews(in: self)
    }
    
    func pagerView(_ pagerView: MXPagerView, viewForPageAt index: Int) -> UIView? {
        return dataSource.segmentedContainer(self, viewFor: index)
    }
    
    @objc private func segmentSelectionChanged() {
        switchTo(index: segmentedControl.selectedSegmentIndex)
    }
    
    @objc private func segmentSectionReselected() {
        delegate.segmentedContainer?(self, didReselectedAt: segmentedControl.selectedSegmentIndex)
    }
}

protocol SegmentedContainerViewDataSource {
    
    func numberOfViews(in containerView: SegmentedContainerView) -> Int
    
    func segmentedContainer(_ containerView: SegmentedContainerView, viewFor index: Int) -> UIView
    
    func segmentedContainer(_ containerView: SegmentedContainerView, titleFor index: Int) -> String
    
}

@objc protocol SegmentedContainerViewDelegate: MXScrollViewDelegate {
    
    @objc optional func segmentedContainer(_ containerView: SegmentedContainerView, didReselectedAt index: Int)
    
}
