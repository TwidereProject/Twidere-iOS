//
//  UserProfileController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import KDInteractiveNavigationController
import ALSLayouts
import AttributedLabel

class UserProfileController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var profileBannerView: UIImageView!
    @IBOutlet weak var bannerActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileContainer: ALSRelativeLayout!
    @IBOutlet weak var userButtonsBackground: UIView!
    @IBOutlet weak var descriptionView: AttributedLabel!
    
    var user: User! {
        didSet {
            if (self.isViewLoaded()) {
                display()
            }
        }
    }
    
    override func viewDidLoad() {
        interactiveNavigationBarHidden = true
        navBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navBar.shadowImage = UIImage()
        navBar.delegate = self
        
        profileBannerView.contentMode = .ScaleAspectFill
        
        profileImageView.contentMode = .ScaleAspectFill
        profileImageView.makeCircular()
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.layer.borderWidth = 1
    
        bannerActivityIndicator.hidesWhenStopped = true
        
        descriptionView.font = UIFont.systemFontOfSize(15)
        
        if let viewControllers = self.navigationController?.viewControllers {
            if (viewControllers.count > 1) {
                let item = UINavigationItem(title: self.title!)
                item.hidesBackButton = false
                item.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: nil)
                navBar.topItem?.title = viewControllers[viewControllers.endIndex - 2].navigationItem.title
                navBar.pushNavigationItem(item, animated: false)
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        display()
    }
    
    func display() {
        guard let user = self.user else {
            return
        }
        navBar.items?.last?.title = user.name
        bannerActivityIndicator.startAnimating()
        profileBannerView.displayImage(user.profileBannerUrlForSize(Int(self.view.frame.width)), completed: { image, error, cacheType, url in
            self.bannerActivityIndicator.stopAnimating()
        })
        profileImageView.displayImage(user.profileImageUrlForSize(.Original))
        descriptionView.text = user.descriptionDisplay
    }
    
    override func viewWillLayoutSubviews() {
        //navBar.layoutParams.marginTop = UIApplication.sharedApplication().statusBarFrame.height
        userButtonsBackground.layoutParams.marginTop = profileBannerView.frame.height
    }
    
    func navigationBar(navigationBar: UINavigationBar, shouldPopItem item: UINavigationItem) -> Bool {
        navigationController?.popViewControllerAnimated(true)
        return true
    }

}