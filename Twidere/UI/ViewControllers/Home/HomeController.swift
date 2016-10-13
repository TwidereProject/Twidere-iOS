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

class HomeController: UITabBarController {
    
    @IBOutlet weak var accountProfileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.accountProfileImageView.makeCircular()
        
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
        
        let tabControllers = [homeTimelineController, notificationsTimelineController, messageConversationsController, testController].map { vc -> UIViewController in
            let nvc = UINavigationController(rootViewController: vc)
            nvc.hidesBottomBarWhenPushed = true
            return nvc
        }
        self.setViewControllers(tabControllers, animated: false)
        
//        self.tabLocation = .bottom
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        let insets = UIEdgeInsetsMake(topLayoutGuide.length, 0, tabBar.frame.height, 0)
//        for vc in viewControllers! {
//            if let tv = (vc as? UITableViewController)?.tableView {
//                var contentInset = tv.contentInset, scrollIndicatorInsets = tv.scrollIndicatorInsets
//                contentInset.bottom = insets.bottom
//                scrollIndicatorInsets.bottom = insets.bottom
//                tv.contentInset = contentInset
//                tv.scrollIndicatorInsets = scrollIndicatorInsets
//            }
//        }
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
    
}
