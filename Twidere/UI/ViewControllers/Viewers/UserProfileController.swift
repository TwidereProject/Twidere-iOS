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
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var visualEffectContentView: UIView!
    @IBOutlet weak var userPagesContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userIndicatorPagesContainer: UserIndicatorPagesContainer!
    
    fileprivate var userInfoTags: [[UserInfoTag]]? = nil
    fileprivate var currentViewController: UIViewController!
    
    var user: User! {
        didSet {
            if (self.isViewLoaded) {
                display()
            }
        }
    }
    
    override func viewDidLoad() {
        interactiveNavigationBarHidden = true
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.delegate = self
        
        profileBannerView.contentMode = .scaleAspectFill
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.makeCircular()
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1
        
        bannerActivityIndicator.hidesWhenStopped = true
        
        descriptionView.font = UIFont.systemFontOfSize(15)
        
        if let viewControllers = self.navigationController?.viewControllers {
            if (viewControllers.count > 1) {
                let item = UINavigationItem(title: self.title!)
                item.hidesBackButton = false
                item.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
                navBar.topItem?.title = viewControllers[viewControllers.endIndex - 2].navigationItem.title
                navBar.pushItem(item, animated: false)
            }
        }
        userIndicatorPagesContainer.showDividers = .Middle
        userIndicatorPagesContainer.divider = UIImage.imageWithColor(UIColor(white: 0.5, alpha: 0.2))

        displayPage(0)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        profileImageView.displayImage(user.profileImageUrlForSize(.original))
        descriptionView.text = user.descriptionDisplay
        
        var infoTags = [UserInfoTag]()
        
        var userInfoTags = [[UserInfoTag]]()
        
        if let location = user.location {
            infoTags.append(UserInfoTag(text: "Location: " + location))
        }
        
        if let url = user.url {
            infoTags.append(UserInfoTag(text: "URL: " + url))
        }
        
        userInfoTags.append(infoTags)
        
        if let metadata = user.metadata {
            var countTags = [UserInfoTag]()
            countTags.append(UserInfoTag(text: "\(metadata.followersCount)"))
            countTags.append(UserInfoTag(text: "\(metadata.friendsCount)"))
            countTags.append(UserInfoTag(text: "\(metadata.listedCount)"))
            
            userInfoTags.append(countTags)
        }
        
        self.userInfoTags = userInfoTags
    }
    
    override func viewWillLayoutSubviews() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let navBarHeight = navBar.frame.height
        navBar.frame.origin.y = statusBarHeight
        visualEffectContentView.frame.size.height = statusBarHeight + navBarHeight
        userButtonsBackground.layoutParams.marginTop = profileBannerView.frame.height
        userIndicatorPagesContainer.contentHeight = scrollView.frame.height - statusBarHeight - navBarHeight
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = profileContainer.sizeThatFits(scrollView.frame.size)
    }
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        navigationController?.popViewController(animated: true)
        return true
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        displayPage(sender.selectedSegmentIndex)
    }
    
    func displayPage(_ idx: Int) {
        let pages = UIStoryboard(name: "Pages", bundle: nil)
        let newController: UIViewController
        switch idx {
        default:
            let testController = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
            testController.delegate = HomeController.UserTimelineStatusesListControllerDelegate()
            newController = testController
        }
        
        self.addChildViewController(newController)
        newController.didMove(toParentViewController: self)
        newController.view.frame = self.userPagesContainer.bounds;
        self.userPagesContainer.addSubview(newController.view)
        self.currentViewController?.removeFromParentViewController()
    }
    
    struct UserInfoTag {
        var text: String
    }
    
}

extension UIImage {
    
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
