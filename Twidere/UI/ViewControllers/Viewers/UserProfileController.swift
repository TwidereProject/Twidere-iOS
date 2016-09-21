//
//  UserProfileController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import ALSLayouts
import AttributedLabel
import MXParallaxHeader
import FXBlurView

class UserProfileController: UIViewController, UINavigationBarDelegate, SegmentedContainerViewDelegate, SegmentedContainerViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var profileBannerContainer: ProfileBannerContainer!
    @IBOutlet weak var profileBannerView: UIImageView!
    @IBOutlet weak var blurredBannerView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileContainer: ALSRelativeLayout!
    @IBOutlet weak var userButtonsBackground: UIView!
    @IBOutlet weak var descriptionView: AttributedLabel!
    @IBOutlet weak var segmentedContainerView: SegmentedContainerView!
    
    fileprivate var userInfoTags: [[UserInfoTag]]? = nil
    fileprivate var viewControllers: [UIViewController?] = [UIViewController?](repeating: nil, count: 3)
    fileprivate var profileImageExceddedSize: CGFloat = CGFloat.nan
    fileprivate var profileImageSize: CGFloat = CGFloat.nan
    
    var user: User! {
        didSet {
            if (self.isViewLoaded) {
                display()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.delegate = self
        
        profileBannerView.contentMode = .scaleAspectFill
        blurredBannerView.contentMode = .scaleAspectFill
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.makeCircular()
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 1
        
        self.segmentedContainerView.dataSource = self
        self.segmentedContainerView.delegate = self
        
        self.segmentedContainerView.contentDividerSize = 0.5
        self.segmentedContainerView.contentDividerColor = UIColor.lightGray
        
        self.segmentedContainerView.parallaxHeader.view = self.profileContainer
        self.segmentedContainerView.parallaxHeader.mode = .bottom
        
        self.segmentedContainerView.parallaxHeader.contentView.layoutMargins = UIEdgeInsets.zero
        
        self.blurredBannerView.alpha = 0
        
        descriptionView.font = UIFont.systemFont(ofSize: 15)
        
        if let viewControllers = self.navigationController?.viewControllers {
            if (viewControllers.count > 1) {
                let item = UINavigationItem(title: self.title!)
                item.hidesBackButton = false
                item.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
                navBar.topItem?.title = viewControllers[viewControllers.endIndex - 2].navigationItem.title
                navBar.pushItem(item, animated: false)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.setNavigationBarHidden(true, animated: animated)
        if let recognizer = self.navigationController?.interactivePopGestureRecognizer {
            recognizer.isEnabled = true
            if let delegate = navigationController as? UIGestureRecognizerDelegate {
                recognizer.delegate = delegate
            }
        }
        
        display()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController!.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillLayoutSubviews() {
        let app = UIApplication.shared
        let statusBarHeight = app.isStatusBarHidden ? 0 : app.statusBarFrame.height
        let navBarHeight = self.navigationController!.navigationBar.frame.height
        
        navBar.layoutParams.marginTop = statusBarHeight
        
        self.segmentedContainerView.parallaxHeader.minimumHeight = statusBarHeight + navBarHeight
        
        self.profileContainer.frame = CGRect.zero
        
        self.profileContainer.frame.size = self.profileContainer.sizeThatFits(self.segmentedContainerView.frame.size)
        
        self.segmentedContainerView.parallaxHeader.height = self.profileContainer.frame.height
        
    }
    
    override func viewDidLayoutSubviews() {
        self.profileImageSize = profileImageView.frame.height
        self.profileImageExceddedSize = profileImageSize - userButtonsBackground.frame.height
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func display() {
        guard let user = self.user else {
            return
        
        }
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes?[NSForegroundColorAttributeName] = UIColor.white
        navBar.items?.last?.title = user.name
        profileBannerView.displayImage(user.profileBannerUrlForSize(Int(self.view.frame.width)), completed: { image, error, cacheType, url in
            if let image = image {
                self.blurredBannerView.image = image.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
            } else {
                self.blurredBannerView.image = nil
            }
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
    
    func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        _ = navigationController?.popViewController(animated: true)
        return true
    }
    
    // MARK: ScrollView delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateBannerScaleTransfom()
    }
    
    func scrollView(_ scrollView: MXScrollView, shouldScrollWithSubView subView: UIScrollView) -> Bool {
        return true
    }
    
    func updateBannerScaleTransfom() {
        guard let navigationController = self.navigationController else {
            return
        }
        
        let topOffset = segmentedContainerView.contentOffset.y
        let bannerHeight = profileBannerContainer.bounds.height
        
        
        let app = UIApplication.shared
        let statusBarHeight = app.isStatusBarHidden ? 0 : app.statusBarFrame.height
        let navBarHeight = navigationController.navigationBar.frame.height
        
        var bannerTransform = CATransform3DIdentity
        var profileImageTransform = CATransform3DIdentity
        
        if (topOffset < 0) {
            
            let headerScaleFactor: CGFloat = max(0, -topOffset) / bannerHeight
            let headerSizevariation = ((bannerHeight * (1.0 + headerScaleFactor)) - bannerHeight) / 2
            
            bannerTransform = CATransform3DTranslate(bannerTransform, 0, headerSizevariation + topOffset, 0)
            bannerTransform = CATransform3DScale(bannerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            self.blurredBannerView.alpha = min(1, -topOffset / 30)
        } else if (topOffset > (bannerHeight - statusBarHeight - navBarHeight)) {
            bannerTransform = CATransform3DTranslate(bannerTransform, 0, topOffset - (bannerHeight - statusBarHeight - navBarHeight), 1)
            let diff = profileImageExceddedSize
            let scaleFactor = diff / profileImageSize
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - scaleFactor, 1.0 - scaleFactor, 0)
            profileImageTransform = CATransform3DTranslate(profileImageTransform, -diff, diff, 0)
            // Show blurred banner
            self.blurredBannerView.alpha = 1
        } else if (topOffset > (bannerHeight - statusBarHeight - navBarHeight - profileImageExceddedSize)) {
            let diff = topOffset - (bannerHeight - statusBarHeight - navBarHeight - profileImageExceddedSize)
            let scaleFactor = diff / profileImageSize
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - scaleFactor, 1.0 - scaleFactor, 0)
            profileImageTransform = CATransform3DTranslate(profileImageTransform, -diff, diff, 0)
            
            self.blurredBannerView.alpha = min(1, diff / 10)
        } else {
            self.blurredBannerView.alpha = 0
        }
        // Apply Transformations
        profileBannerContainer.layer.transform = bannerTransform
        profileImageView.layer.transform = profileImageTransform
    }
    
    func numberOfViews(in containerView: SegmentedContainerView) -> Int {
        return 3
    }
    
    func segmentedContainer(_ containerView: SegmentedContainerView, titleFor index: Int) -> String {
        switch index {
        case 0:
            return "Tweets"
        case 1:
            return "Media"
        case 2:
            return "Favorites"
        default:
            abort()
        }
    }
    
    func segmentedContainer(_ containerView: SegmentedContainerView, viewFor index: Int) -> UIView {
        let newController: UIViewController
        if let cached = viewControllers[index] {
            newController = cached
        } else {
            switch index {
            case 0:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                let vc = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
                let account = getAccount(forKey: user.accountKey)!
                let statusesDelegate = UserTimelineStatusesListControllerDelegate(account: account, userKey: user.key, screenName: user.screenName)
                statusesDelegate.refreshEnabled = true
                vc.delegate = statusesDelegate
                newController = vc
            case 1:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                newController = pages.instantiateViewController(withIdentifier: "StubTab")
            case 2:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                let vc = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
                let account = getAccount(forKey: user.accountKey)!
                let statusesDelegate = UserFavoritesStatusesListControllerDelegate(account: account, userKey: user.key, screenName: user.screenName)
                statusesDelegate.refreshEnabled = true
                vc.delegate = statusesDelegate
                newController = vc
            default:
                abort()
            }
            viewControllers[index] = newController
        }
        
        self.addChildViewController(newController)
        newController.didMove(toParentViewController: self)
        return newController.view
    }
    
    func segmentedContainer(_ containerView: SegmentedContainerView, didReselectedAt index: Int) {
        guard let vc = self.viewControllers[index] else {
            return
        }
        switch vc {
        case let tvc as UITableViewController:
            let tbv = tvc.tableView!
            let inset = tbv.contentInset
            tbv.setContentOffset(CGPoint(x: -inset.left, y: -inset.top), animated: true)
        default:
            break
        }
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
