//
//  UserProfileController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import ALSLayouts
import YYText
import MXParallaxHeader
import FXBlurView
import PromiseKit
import SQLite

typealias UserInfo = (accountKey: UserKey, userKey: UserKey?, screenName: String?)

class UserProfileController: UIViewController, UINavigationBarDelegate, SegmentedContainerViewDelegate, SegmentedContainerViewDataSource, StatusesListControllerDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var profileBannerContainer: ProfileBannerContainer!
    @IBOutlet weak var profileBannerView: UIImageView!
    @IBOutlet weak var blurredBannerView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileContainer: ALSRelativeLayout!
    @IBOutlet weak var userButtonsBackground: UIView!
    @IBOutlet weak var profileRefreshIndicator: ActivityIndicator!
    
    @IBOutlet weak var userActionButton: UIButton!
    @IBOutlet weak var nameView: YYLabel!
    @IBOutlet weak var screenNameView: YYLabel!
    @IBOutlet weak var descriptionView: YYLabel!
    @IBOutlet weak var segmentedContainerView: SegmentedContainerView!
    
    fileprivate var userInfoTags: [[UserInfoTag]]? = nil
    fileprivate var viewControllers: [UIViewController?] = [UIViewController?](repeating: nil, count: 3)
    fileprivate var profileImageExceddedHeight: CGFloat = CGFloat.nan
    fileprivate var profileImageHeight: CGFloat = CGFloat.nan
    
    private var user: User!
    private var userInfo: UserInfo!
    private var reloadNeeded: Bool = false
    
    private var bannerShadowLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(white: 0, alpha: 0.3).cgColor, UIColor(white: 0, alpha: 0.1).cgColor, UIColor(white: 0, alpha: 0).cgColor]
        layer.zPosition = 1
        return layer
    }()
    
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
        profileImageView.layer.borderWidth = 2
        
        self.segmentedContainerView.dataSource = self
        self.segmentedContainerView.delegate = self
        
        self.segmentedContainerView.contentDividerSize = 0.5
        self.segmentedContainerView.contentDividerColor = UIColor.lightGray
        
        self.segmentedContainerView.parallaxHeader.view = self.profileContainer
        self.segmentedContainerView.parallaxHeader.mode = .bottom
        
        self.segmentedContainerView.parallaxHeader.contentView.layoutMargins = UIEdgeInsets.zero
        
        self.segmentedContainerView.layer.addSublayer(self.bannerShadowLayer)
        
        self.blurredBannerView.alpha = 0
        
        nameView.font = UIFont.systemFont(ofSize: 15)
        screenNameView.font = UIFont.systemFont(ofSize: 12)
        descriptionView.font = UIFont.systemFont(ofSize: 15)
        
        navBar.tintColor = UIColor.white
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = UIColor(white: 0, alpha: 0.5)
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSShadowAttributeName: shadow
        ]
        let backImageOriginal = UIImage(named: "NavBar Button Back")!
        let backImageShadowed = backImageOriginal.withShadow(shadow).withRenderingMode(.alwaysOriginal).withAlignmentRectInsets(shadow.shadowedImageInset(size: backImageOriginal.size))
        
        navBar.backIndicatorImage = backImageShadowed
        navBar.backIndicatorTransitionMaskImage = backImageShadowed
        
        if let viewControllers = self.navigationController?.viewControllers {
            if (viewControllers.count > 1) {
                var items = navBar.items!
                items.insert(UINavigationItem(title: ""), at: 0)
                navBar.setItems(items, animated: false)
            }
        }
        
        navBar.topItem?.rightBarButtonItems?.forEach { item in
            item.makeShadowed(shadow)
        }
        
        if (self.user != nil) {
            displayUser()
            if (self.reloadNeeded) {
                self.loadUser()
            }
        } else if (self.userInfo != nil) {
            loadUser()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = self.navigationController {
            navigationController.setNavigationBarHidden(true, animated: animated)
            if let recognizer = navigationController.interactivePopGestureRecognizer {
                recognizer.isEnabled = true
                if let delegate = navigationController as? UIGestureRecognizerDelegate {
                    recognizer.delegate = delegate
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = self.navigationController {
            let top = navigationController.topViewController
            navigationController.setNavigationBarHidden(top is UserProfileController, animated: animated)
        }
    }
    
    override func viewWillLayoutSubviews() {
        let navBarHeight = self.navigationController!.navigationBar.frame.height
        let topLayoutGuideLength = topLayoutGuide.length
        let topBarsHeight = topLayoutGuideLength + navBarHeight
        
        let containerSize = self.segmentedContainerView.frame.size
        
        navBar.frame.origin.y = topLayoutGuideLength
        navBar.frame.size.height = navBarHeight
        
        self.segmentedContainerView.parallaxHeader.minimumHeight = topBarsHeight
        
        self.profileContainer.frame = CGRect.zero
        
        self.profileContainer.frame.size = self.profileContainer.sizeThatFits(containerSize)
        
        self.segmentedContainerView.parallaxHeader.height = self.profileContainer.frame.height
        
        self.bannerShadowLayer.frame.size = CGSize(width: containerSize.width, height: topBarsHeight)
    }
    
    override func viewDidLayoutSubviews() {
        if (self.profileImageHeight.isNaN || self.profileImageExceddedHeight.isNaN) {
            self.profileImageHeight = profileImageView.frame.height
            self.profileImageExceddedHeight = profileImageHeight - userButtonsBackground.frame.height
        }
        updateBannerScaleTransfom(false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func displayUser(user: User, reload: Bool = false) {
        self.user = user
        self.userInfo = (user.accountKey, user.key, user.screenName)
        if (self.isViewLoaded) {
            self.displayUser()
        }
        self.reloadNeeded = reload
        if (reload) {
            self.loadUser(userInfo: self.userInfo)
        }
    }
    
    func loadUser(userInfo: UserInfo) {
        self.userInfo = userInfo
        if (self.isViewLoaded) {
            self.loadUser()
        }
    }
    
    fileprivate func loadUser() {
        guard let userInfo = self.userInfo else {
            return
        }
        self.reloadNeeded = false
        _ = DispatchQueue.global().promise { () -> Account in
            return getAccount(forKey: userInfo.accountKey)!
            }.then { account -> Promise<User> in
                let api = account.newMicroBlogService()
                if let key = userInfo.userKey {
                    return api.showUser(id: key.id)
                } else if let screenName = userInfo.screenName {
                    return api.showUser(screenName: screenName)
                }
                return Promise(error: MicroBlogError.argumentError(message: "Invalid user info"))
            }.then { user -> Void in
                self.displayUser(user: user)
                // Save user
                if (user.accountKey == user.key) {
                    _ = DispatchQueue.global().promise { () -> Void in
                        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
                        let update = accountsTable.filter(Account.RowIndices.key == user.accountKey).update(Account.RowIndices.user <- user)
                        _ = try db.run(update)
                    }
                }
        }
        
    }
    
    fileprivate func displayUser() {
        guard let user = self.user else {
            return
            
        }
        self.title = user.name
        navBar.topItem?.title = user.name
        profileBannerView.displayImage(user.profileBannerUrlForSize(Int(self.view.frame.width)), completed: { image, error, cacheType, url in
            if let image = image {
                self.blurredBannerView.image = image.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
            } else {
                self.blurredBannerView.image = nil
            }
        })
        profileImageView.displayImage(user.profileImageUrlForSize(.original), placeholder: UIImage.withColor(UIColor.white))
        nameView.text = user.name
        screenNameView.text = user.screenName
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
        self.updateBannerScaleTransfom(scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating)
    }
    
    func scrollView(_ scrollView: MXScrollView, shouldScrollWithSubView subView: UIScrollView) -> Bool {
        return true
    }
    
    private func updateBannerScaleTransfom(_ fromUserInteraction: Bool) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        let topOffset = segmentedContainerView.contentOffset.y
        let bannerHeight = profileBannerContainer.bounds.height
        
        let topLayoutGuideLength = topLayoutGuide.length
        let navBarHeight = navigationController.navigationBar.frame.height
        
        var bannerTransform = CATransform3DIdentity
        var profileImageTransform = CATransform3DIdentity
        
        var titleTextAttributes = navBar.titleTextAttributes
        
        var titleTextColor = UIColor.white
        var indicatorOffset: CGFloat = 0
        var indicatorProgress: CGFloat = 0
        
        if (topOffset < 0) {
            let headerScaleFactor: CGFloat = max(0, -topOffset) / bannerHeight
            let headerSizevariation = ((bannerHeight * (1.0 + headerScaleFactor)) - bannerHeight) / 2
            
            bannerTransform = CATransform3DTranslate(bannerTransform, 0, headerSizevariation + topOffset, 0)
            bannerTransform = CATransform3DScale(bannerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            indicatorOffset = -(headerSizevariation + topOffset)
            indicatorProgress = (-topOffset / 60)
            
            self.blurredBannerView.alpha = min(1, -topOffset / 30)
            titleTextColor = titleTextColor.withAlphaComponent(0)
        } else if (topOffset > (bannerHeight - topLayoutGuideLength - navBarHeight)) {
            bannerTransform = CATransform3DTranslate(bannerTransform, 0, topOffset - (bannerHeight - topLayoutGuideLength - navBarHeight), 1)
            let diff = profileImageExceddedHeight
            let scaleFactor = diff / profileImageHeight
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - scaleFactor, 1.0 - scaleFactor, 0)
            profileImageTransform = CATransform3DTranslate(profileImageTransform, -diff, diff, 0)
            // Show blurred banner
            self.blurredBannerView.alpha = 1
            
            let buttonsHeight = userButtonsBackground.frame.height
            let alphaMaxOffset = bannerHeight - topLayoutGuideLength - navBarHeight
            titleTextColor = titleTextColor.withAlphaComponent(min((topOffset - alphaMaxOffset) / buttonsHeight, 1))
        } else if (topOffset > (bannerHeight - topLayoutGuideLength - navBarHeight - profileImageExceddedHeight)) {
            let diff = topOffset - (bannerHeight - topLayoutGuideLength - navBarHeight - profileImageExceddedHeight)
            let scaleFactor = diff / profileImageHeight
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - scaleFactor, 1.0 - scaleFactor, 0)
            profileImageTransform = CATransform3DTranslate(profileImageTransform, -diff, diff, 0)
            
            self.blurredBannerView.alpha = min(1, diff / 10)
            titleTextColor = titleTextColor.withAlphaComponent(0)
        } else {
            self.blurredBannerView.alpha = 0
            titleTextColor = titleTextColor.withAlphaComponent(0)
        }
        
        titleTextAttributes?[NSForegroundColorAttributeName] = titleTextColor
        // Apply Transformations
        profileBannerContainer.layer.transform = bannerTransform
        profileImageView.layer.transform = profileImageTransform
        
        profileRefreshIndicator.layer.bounds.origin.y = -(bannerHeight - profileRefreshIndicator.frame.height) / 2 + indicatorOffset
        if (fromUserInteraction && !self.profileRefreshIndicator.animationStarted) {
            if (indicatorProgress >= 1) {
                self.profileRefreshIndicator.startAnimation()
                if let vc = self.viewControllers[self.segmentedContainerView.selectedViewIndex] as? PullToRefreshProtocol {
                    vc.refreshFromStart()
                }
            } else {
                self.profileRefreshIndicator.showProgress(indicatorProgress)
            }
        }
        navBar.titleTextAttributes = titleTextAttributes
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
        } else if let userInfo = self.userInfo {
            switch index {
            case 0:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                let vc = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
                let account = getAccount(forKey: userInfo.accountKey)!
                vc.dataSource = UserTimelineStatusesListControllerDataSource(account: account, userKey: userInfo.userKey, screenName: userInfo.screenName)
                vc.delegate = self
                newController = vc
            case 1:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                newController = pages.instantiateViewController(withIdentifier: "StubTab")
            case 2:
                let pages = UIStoryboard(name: "Pages", bundle: nil)
                let vc = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
                let account = getAccount(forKey: userInfo.accountKey)!
                vc.dataSource = UserFavoritesStatusesListControllerDataSource(account: account, userKey: userInfo.userKey, screenName: userInfo.screenName)
                vc.delegate = self
                newController = vc
            default:
                abort()
            }
            viewControllers[index] = newController
        } else {
            let pages = UIStoryboard(name: "Pages", bundle: nil)
            newController = pages.instantiateViewController(withIdentifier: "StubTab")
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
    
    func refreshEnded() {
        self.profileRefreshIndicator.stopAnimation()
    }
    
    struct UserInfoTag {
        var text: String
    }
}

