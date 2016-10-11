//
//  HomeViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SDWebImage
import UIView_TouchHighlighting
import PromiseKit
import SQLite
import MXPagerView

class HomeController: MXPagerViewController {
    
    @IBOutlet weak var accountProfileImageView: UIImageView!
    @IBOutlet weak var menuToggleItem: UIBarButtonItem!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
        menuToggleItem.customView?.touchHighlightingStyle = .transparentMask
        
        let pages = UIStoryboard(name: "Pages", bundle: nil)
        
        let homeTimelineController = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
        homeTimelineController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab Icon Home"), tag: 1)
        homeTimelineController.dataSource = HomeTimelineStatusesListControllerDataSource()
        let notificationsTimelineController = pages.instantiateViewController(withIdentifier: "ActivitiesList") as! ActivitiesListController
        notificationsTimelineController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "Tab Icon Notification"), tag: 2)
        notificationsTimelineController.dataSource = InteractionsActivitiesListControllerDataSource()
        let messageConversationsController = pages.instantiateViewController(withIdentifier: "StubTab")
        messageConversationsController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Tab Icon Message"), tag: 3)
        let testController = pages.instantiateViewController(withIdentifier: "StubTab")
        testController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "Tab Icon User"), tag: 4)
        
        pagerView.isScrollEnabled = false
        self.viewControllers = [homeTimelineController, notificationsTimelineController, messageConversationsController, testController]
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let insets = UIEdgeInsetsMake(topLayoutGuide.length, 0, 0, 0)
        for vc in viewControllers! {
            if let tv = (vc as? UITableViewController)?.tableView {
                var contentInset = tv.contentInset, scrollIndicatorInsets = tv.scrollIndicatorInsets
                contentInset.top = insets.top
                scrollIndicatorInsets.top = insets.top
                tv.contentInset = contentInset
                tv.scrollIndicatorInsets = scrollIndicatorInsets
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = DispatchQueue.global().promise { () -> Account in
            return try defaultAccount()!
        }.then { account -> Void in
            self.accountProfileImageView.displayImage(account.user!.profileImageUrlForSize(.reasonablySmall), placeholder: UIImage(named: "Profile Image Default"))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeClicked(_ sender: UIBarButtonItem) {
        ComposeController.create().show(parent: self.parent ?? self)
    }
    
    @IBAction func accountIconClicked(_ sender: UITapGestureRecognizer) {
        sender.isEnabled = false
        _ = DispatchQueue.global().promise { () -> Account in
            return try defaultAccount()!
        }.then { account -> Void in
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "AccountProfile") as! UserProfileController
            vc.displayUser(user: account.user, reload: true)
            self.navigationController?.show(vc, sender: self)
        }.always {
            sender.isEnabled = true
        }
    }
    
    override func numberOfPages(in pagerView: MXPagerView) -> Int {
        return self.viewControllers.count
    }
    
    override func pagerView(_ pagerView: MXPagerView, viewControllerForPageAt index: Int) -> UIViewController {
        return viewControllers[index]
    }
 
    
}
