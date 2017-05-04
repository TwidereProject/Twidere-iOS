//
//  ActivityIndicator.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/28.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import PromiseKit

class ActivityIndicator: UIView {
    static let numberOfMarkers: Int = 12
    
    override var frame: CGRect {
        get { return CGRect(origin: super.frame.origin, size: self.indicatorSize) }
        set {
            super.frame = CGRect(origin: newValue.origin, size: self.indicatorSize)
            self.updateLayers()
        }
    }
    
    lazy var opacityAnim: CAAnimation = {
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = CGFloat(1.0)
        opacity.toValue = CGFloat(0.0)
        opacity.repeatCount = Float.infinity
        opacity.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        opacity.duration = 1
        return opacity
    }()
    
    lazy var markerLayer: CALayer = {
        let layer = CALayer()
        return layer
    }()
    
    lazy var spinnerReplicator: CAReplicatorLayer = {
        let layer = CAReplicatorLayer()
        let angle: CGFloat = (2.0 * CGFloat.pi) / CGFloat(ActivityIndicator.numberOfMarkers)
        layer.instanceTransform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        layer.addSublayer(self.markerLayer)
        return layer
    }()
    
    var activityIndicatorStyle: UIActivityIndicatorViewStyle = .gray {
        didSet {
            let frame = self.frame
            self.frame = frame
            updateLayers()
        }
    }
    
    private var markerProgress: CGFloat = 0
    private(set) var animationStarted: Bool = false
    
    func showProgress(_ progress: CGFloat) {
        self.markerProgress = progress
        updateMarkers()
    }
    
    func startAnimation() {
        markerLayer.removeAnimation(forKey: "ActivityIndicatorAnim")
        self.animationStarted = true
        spinnerReplicator.instanceDelay = 1.0 / Double(ActivityIndicator.numberOfMarkers)
        markerLayer.add(self.opacityAnim, forKey: "ActivityIndicatorAnim")
    }
    
    func stopAnimation() {
        spinnerReplicator.instanceDelay = 0
        markerLayer.removeAnimation(forKey: "ActivityIndicatorAnim")
        self.animationStarted = false
        UIView.animate(withDuration: 0.25) {
            self.showProgress(0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.addSublayer(spinnerReplicator)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.indicatorSize
    }
    
    func updateLayers() {
        let indicatorSize = self.indicatorSize
        let markerSize = indicatorMarkerSize
        markerLayer.bounds = CGRect(origin: CGPoint.zero, size: markerSize)
        markerLayer.cornerRadius = markerSize.width / 2
        markerLayer.position = CGPoint(x: indicatorSize.width / 2, y: markerSize.height / 2)
        markerLayer.backgroundColor = UIColor.white.cgColor
        spinnerReplicator.bounds = CGRect(origin: CGPoint.zero, size: self.frame.size)
        spinnerReplicator.position = CGPoint(x: spinnerReplicator.bounds.midX, y: spinnerReplicator.bounds.midY)
        updateMarkers()
    }
    
    func updateMarkers() {
        let count: Int
        if (animationStarted) {
            count = ActivityIndicator.numberOfMarkers
        } else {
            count = min(ActivityIndicator.numberOfMarkers, Int(round((CGFloat(ActivityIndicator.numberOfMarkers) * markerProgress))))
        }
        spinnerReplicator.instanceCount = count
        spinnerReplicator.isHidden = count <= 0
            
    }
    
    private var indicatorSize: CGSize {
        switch activityIndicatorStyle {
        case .whiteLarge:
            return CGSize(width: 37, height: 37)
        default:
            return CGSize(width: 20, height: 20)
        }
    }
    
    private var indicatorMarkerSize: CGSize {
        switch activityIndicatorStyle {
        case .whiteLarge:
            return CGSize(width: 4, height: 10)
        default:
            return CGSize(width: 2, height: 5)
        }
        
    }
    
}
