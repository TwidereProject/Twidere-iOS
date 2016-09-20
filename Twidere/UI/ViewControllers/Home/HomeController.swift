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
import SwiftyJSON

class HomeController: UITabBarController {
    
    @IBOutlet weak var accountProfileImageView: UIImageView!
    @IBOutlet weak var menuToggleItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
        menuToggleItem.customView?.touchHighlightingStyle = .transparentMask
        
        let pages = UIStoryboard(name: "Pages", bundle: nil)
        
        let homeTimelineController = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
        homeTimelineController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab Icon Home"), tag: 1)
        homeTimelineController.delegate = HomeTimelineStatusesListControllerDelegate()
        let notificationsTimelineController = pages.instantiateViewController(withIdentifier: "StubTab")
        notificationsTimelineController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "Tab Icon Notification"), tag: 2)
        let messageConversationsController = pages.instantiateViewController(withIdentifier: "StubTab")
        messageConversationsController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Tab Icon Message"), tag: 3)
        let testController = pages.instantiateViewController(withIdentifier: "StubTab")
        testController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "Tab Icon User"), tag: 4)
        setViewControllers([homeTimelineController, notificationsTimelineController, messageConversationsController, testController], animated: false)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let bottomOffset = tabBar.frame.height
        for vc in viewControllers! {
            if let tv = (vc as? UITableViewController)?.tableView {
                var contentInset = tv.contentInset, scrollIndicatorInsets = tv.scrollIndicatorInsets
                contentInset.bottom = bottomOffset
                scrollIndicatorInsets.bottom = bottomOffset
                tv.contentInset = contentInset
                tv.scrollIndicatorInsets = scrollIndicatorInsets
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let account = try! defaultAccount()!
        accountProfileImageView.displayImage(account.user!.profileImageUrlForSize(.reasonablySmall), placeholder: UIImage(named: "Profile Image Default"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeClicked(_ sender: UIBarButtonItem) {
        ComposeController.show(self.parent ?? self, identifier: "Compose")
    }
    
    @IBAction func accountIconClicked(_ sender: UITapGestureRecognizer) {
        let account = try! defaultAccount()!
        let vc = storyboard!.instantiateViewController(withIdentifier: "AccountProfile") as! UserProfileController
        vc.user = account.user
        navigationController?.show(vc, sender: self)
    }
    
 
    
}
