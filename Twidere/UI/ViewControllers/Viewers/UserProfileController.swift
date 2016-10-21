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
import SwiftHEXColors
import DateTools

typealias UserInfo = (accountKey: UserKey, userKey: UserKey?, screenName: String?)

class UserProfileController: UIViewController, UINavigationBarDelegate, SegmentedContainerViewDelegate, SegmentedContainerViewDataSource, StatusesListControllerDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var profileBannerContainer: ProfileBannerContainer!
    @IBOutlet weak var profileBannerView: UIImageView!
    @IBOutlet weak var blurredBannerView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileImageContainer: UIView!
    @IBOutlet weak var profileContainer: ALSRelativeLayout!
    @IBOutlet weak var userButtonsBackground: UIView!
    @IBOutlet weak var profileRefreshIndicator: ActivityIndicator!
    
    @IBOutlet weak var userActionButton: ActionIconButton!
    @IBOutlet weak var nameView: YYLabel!
    @IBOutlet weak var screenNameView: YYLabel!
    @IBOutlet weak var descriptionView: YYLabel!
    @IBOutlet weak var segmentedContainerView: SegmentedContainerView!
    @IBOutlet weak var userActionContainer: ALSFrameLayout!
    
    fileprivate var viewControllers: [UIViewController?] = [UIViewController?](repeating: nil, count: 3)
    fileprivate var profileImageExceddedHeight: CGFloat = CGFloat.nan
    fileprivate var profileImageHeight: CGFloat = CGFloat.nan
    fileprivate var cellDisplayOption: StatusCell.DisplayOption! = StatusCell.DisplayOption()
    
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
        cellDisplayOption.loadUserDefaults()
        
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.delegate = self
        
        profileBannerView.contentMode = .scaleAspectFill
        blurredBannerView.contentMode = .scaleAspectFill
        
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.makeCircular()
        
        let border = CALayerBorder(color: UIColor.white.cgColor, width: 2)
        let shadow = CALayerShadow(color: UIColor.black.cgColor, offset: CGSize(width: 0, height: 1), blurRadius: 2, opacity: 0.33)
        self.profileImageContainer.layer.makeCircular(border: border, shadow: shadow)
        self.profileImageContainer.clipsToBounds = false
        
        self.segmentedContainerView.dataSource = self
        self.segmentedContainerView.delegate = self
        
        self.segmentedContainerView.contentDividerSize = 0.5
        self.segmentedContainerView.contentDividerColor = UIColor.lightGray
        
        self.segmentedContainerView.parallaxHeader.view = self.profileContainer
        self.segmentedContainerView.parallaxHeader.mode = .bottom
        
        self.segmentedContainerView.parallaxHeader.contentView.layoutMargins = UIEdgeInsets.zero
        
        self.segmentedContainerView.layer.addSublayer(self.bannerShadowLayer)
        
        self.blurredBannerView.alpha = 0
        
        descriptionView.displaysAsynchronously = true
        nameView.displaysAsynchronously = true
        screenNameView.displaysAsynchronously = true
        
        
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
        setupNavBar()
        updateBannerScaleTransfom(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = self.navigationController {
            let top = navigationController.topViewController
            navigationController.setNavigationBarHidden(top is UserProfileController, animated: animated)
        }
    }
    
    override func viewWillLayoutSubviews() {
        let topLayoutGuideLength = topLayoutGuide.length
        
        let containerSize = self.segmentedContainerView.frame.size
        
        navBar.frame.origin.y = topLayoutGuideLength
        if let navigationController = self.navigationController {
            navBar.frame.size.height = navigationController.navigationBar.frame.height
            navBar.isHidden = false
        } else {
            navBar.isHidden = true
        }
        
        let topBarsHeight = topLayoutGuideLength + navBar.frame.size.height
        
        self.segmentedContainerView.parallaxHeader.minimumHeight = topBarsHeight
        
        self.profileContainer.frame = CGRect.zero
        
        self.profileContainer.frame.size = self.profileContainer.sizeThatFits(containerSize)
        
        self.segmentedContainerView.parallaxHeader.height = self.profileContainer.frame.height
        
        self.bannerShadowLayer.frame.size = CGSize(width: containerSize.width, height: topBarsHeight)
    }
    
    override func viewDidLayoutSubviews() {
        if (self.profileImageHeight.isNaN || self.profileImageExceddedHeight.isNaN) {
            self.profileImageHeight = profileImageContainer.frame.height
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
            displayUser()
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
    
    private func setupNavBar() {
        
        navBar.tintColor = UIColor.white
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = UIColor(white: 0, alpha: 0.5)
        navBar.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.clear,
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
                        let update = accountsTable.filter(Account.RowIndices.key == user.accountKey!).update(Account.RowIndices.user <- user)
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
        let placeholder = UIImage.withColor(user.metadata?.backgroundUIColor ?? UIColor.white)
        profileBannerView.displayImage(user.profileBannerUrlForSize(Int(self.view.frame.width)), placeholder: placeholder, completed: { image, error, cacheType, url in
            if let image = image {
                self.blurredBannerView.image = image.blurredImage(withRadius: 10, iterations: 20, tintColor: UIColor.clear)
            } else {
                self.blurredBannerView.image = nil
            }
        })
        profileImageView.displayImage(user.profileImageUrlForSize(.original), placeholder: UIImage.withColor(UIColor.white))
        
        nameView.attributedText = NSAttributedString(string: user.name, attributes: [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15.5)
            ])
        screenNameView.attributedText = NSAttributedString(string: "@\(user.screenName)", attributes: [
            NSFontAttributeName: UIFont.systemFont(ofSize: 13)
            ])
        
        let descriptionFont = UIFont.systemFont(ofSize: 15)
        
        let descriptionText = NSMutableAttributedString()
        
        descriptionText.yy_font = descriptionFont
        
        if let descriptionDisplay = user.descriptionDisplay {
            descriptionText.append(UserProfileController.createDescriptionText(descriptionDisplay, metadata: user.metadata, font: descriptionFont, displayOption: self.cellDisplayOption))
        }
        if let location = user.location, !location.isEmpty {
            descriptionText.yy_appendString("\n")
            let image = UIImage(named: "Text Icon Location")!
            descriptionText.yy_appendAttachment(with: image, contentMode: .center, attachmentSize: image.size, alignTo: descriptionFont, alignment: .center)
            
            descriptionText.yy_appendStringRemoveHighlight(location)
        }
        if let urlDisplay = user.urlDisplay ?? user.url, let url = user.urlExpanded ?? user.url, !urlDisplay.isEmpty, !url.isEmpty {
            descriptionText.yy_appendString("\n")
            let image = UIImage(named: "Text Icon Web")!
            descriptionText.yy_appendAttachment(with: image, contentMode: .center, attachmentSize: image.size, alignTo: descriptionFont, alignment: .center)
            
            descriptionText.yy_appendTextHighlight(string: urlDisplay, color: cellDisplayOption.linkColor, backgroundColor: nil, userInfo: [highlightUserInfoKey: LinkSpanItem(link: url)])
        }
        if let createdAt = user.createdAt as NSDate? {
            descriptionText.yy_appendString("\n")
            let image = UIImage(named: "Text Icon Time")!
            descriptionText.yy_appendAttachment(with: image, contentMode: .center, attachmentSize: image.size, alignTo: descriptionFont, alignment: .center)
            
            descriptionText.yy_appendStringRemoveHighlight(createdAt.formattedDate(with: .long))
            if let metadata = user.metadata, metadata.statusesCount >= 0 {
                let tweetsPerDay = Int64(round(Double(metadata.statusesCount) / Double(createdAt.daysAgo())))
                descriptionText.yy_appendStringRemoveHighlight(" (\(tweetsPerDay.shortLocalizedString) tweets per day)")
            }
        }
        descriptionView.attributedText = descriptionText
        if user.accountKey == user.key {
            let image = #imageLiteral(resourceName: "Button Follow Empty")
            userActionButton.templateImage = image
            userActionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, 0)
            userActionButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
            userActionButton.setTitle("Edit", for: .normal)
            userActionButton.tintColor = materialLightBlue300
        } else if let metadata = user.metadata {
            userActionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, -4)
            userActionButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 12)
            if (metadata.blocking) {
                userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow Block")
                userActionButton.setTitle("Blocking", for: .normal)
                userActionButton.tintColor = materialLightBlue300
            } else if (metadata.followRequestSent) {
                userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow Pending")
                userActionButton.setTitle("Requested", for: .normal)
                userActionButton.tintColor = materialLightBlue300
            } else if (metadata.following) {
                if (metadata.followedBy) {
                    userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow Mutual")
                } else {
                    userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow Outgoing")
                }
                userActionButton.setTitle("Following", for: .normal)
                userActionButton.tintColor = materialLightBlue300
            } else if (metadata.followedBy) {
                userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow Incoming")
                userActionButton.setTitle("Follow", for: .normal)
                userActionButton.tintColor = materialLightBlue300
            } else {
                userActionButton.templateImage = #imageLiteral(resourceName: "Button Follow")
                userActionButton.setTitle("Follow", for: .normal)
                userActionButton.tintColor = materialLightBlue300
            }
        } else {
            let image = #imageLiteral(resourceName: "Button Follow Empty")
            userActionButton.templateImage = image
            userActionButton.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, 0)
            userActionButton.contentEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
            userActionButton.setTitle("Loading", for: .normal)
            userActionButton.tintColor = materialLightBlue300
        }
        
        userActionButton.layer.makeRoundedCorner(radius: 4, borderColor: userActionButton.tintColor.cgColor, borderWidth: 1)
        
        self.userActionContainer.setNeedsLayout()
        self.userButtonsBackground.setNeedsLayout()
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        updateBannerScaleTransfom(false)
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
        
        if (bannerHeight <= 0) {
            return
        }
        
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
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, diff, 0)
            // Show blurred banner
            self.blurredBannerView.alpha = 1
            
            let buttonsHeight = userButtonsBackground.frame.height
            let alphaMaxOffset = bannerHeight - topLayoutGuideLength - navBarHeight
            titleTextColor = titleTextColor.withAlphaComponent(min((topOffset - alphaMaxOffset) / buttonsHeight, 1))
        } else if (topOffset > (bannerHeight - topLayoutGuideLength - navBarHeight - profileImageExceddedHeight)) {
            let diff = topOffset - (bannerHeight - topLayoutGuideLength - navBarHeight - profileImageExceddedHeight)
            let scaleFactor = diff / profileImageHeight
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - scaleFactor, 1.0 - scaleFactor, 0)
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, diff, 0)
            
            self.blurredBannerView.alpha = min(1, diff / 10)
            titleTextColor = titleTextColor.withAlphaComponent(0)
        } else {
            self.blurredBannerView.alpha = 0
            titleTextColor = titleTextColor.withAlphaComponent(0)
        }
        
        titleTextAttributes?[NSForegroundColorAttributeName] = titleTextColor
        // Apply Transformations
        profileBannerContainer.layer.transform = bannerTransform
        profileImageContainer.layer.transform = profileImageTransform
        
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
    
    @IBAction func userActionTapped(_ sender: ActionIconButton) {
        guard let user = self.user else {
            return
        }
        if user.accountKey == user.key {
            
        } else if let metadata = user.metadata {
            if (metadata.blocking) {
                let ac = PMKAlertController(title: "Unblock \(user.name)", message: nil, preferredStyle: .alert)
                _ = ac.addActionWithTitle(title: "Cancel", style: .cancel)
                _ = ac.addActionWithTitle(title: "Unblock", style: .default)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                promise(ac).then(on: DispatchQueue.global()) { action -> Promise<User> in
                    guard let microBlog = getAccount(forKey: user.accountKey)?.newMicroBlogService() else {
                        return Promise(error: MicroBlogError.argumentError(message: "No account found"))
                    }
                    return microBlog.destroyBlock(id: user.key.id)
                }.then { _ -> Void in
                    self.loadUser()
                }.always {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }.showStatusBarNotificationAfterTask(success: "Unfollowed \(user.name)", failure: "Unable to unfollow \(user.name)")
            } else if (metadata.followRequestSent) {
            } else if (metadata.following) {
                let ac = PMKAlertController(title: "Unfollow \(user.name)", message: nil, preferredStyle: .alert)
                _ = ac.addActionWithTitle(title: "Cancel", style: .cancel)
                _ = ac.addActionWithTitle(title: "Unfollow", style: .destructive)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                promise(ac).then(on: DispatchQueue.global()) { action -> Promise<User> in
                    guard let microBlog = getAccount(forKey: user.accountKey)?.newMicroBlogService() else {
                        return Promise(error: MicroBlogError.argumentError(message: "No account found"))
                    }
                    return microBlog.destroyFriendship(id: user.key.id)
                }.then { _ -> Void in
                    self.loadUser()
                }.always {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }.showStatusBarNotificationAfterTask(success: "Unfollowed \(user.name)", failure: "Unable to unfollow \(user.name)")
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                DispatchQueue.global().promise { action -> Promise<User> in
                    guard let microBlog = getAccount(forKey: user.accountKey)?.newMicroBlogService() else {
                        return Promise(error: MicroBlogError.argumentError(message: "No account found"))
                    }
                    return microBlog.createFriendship(id: user.key.id)
                }.then { _ -> Void in
                    self.loadUser()
                }.always {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }.showStatusBarNotificationAfterTask(success: "Following \(user.name)", failure: "Unable to follow \(user.name)")
            }
        }
    }
    
    static func createDescriptionText(_ text: String, metadata: User.Metadata?, font: UIFont, displayOption: StatusCell.DisplayOption) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        
        attributed.yy_font = font
        
        metadata?.descriptionLinks?.applyToAttributedText(attributed, linkColor: displayOption.linkColor)
        metadata?.descriptionMentions?.applyToAttributedText(attributed, linkColor: displayOption.linkColor)
        metadata?.descriptionHashtags?.applyToAttributedText(attributed, linkColor: displayOption.linkColor)
        return attributed
    }
    
}

