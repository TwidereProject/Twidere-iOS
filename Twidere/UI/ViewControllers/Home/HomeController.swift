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

class HomeController: UITabBarController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pages = UIStoryboard(name: "Pages", bundle: nil)
        let viewers = UIStoryboard(name: "Viewers", bundle: nil)
        
        let homeTimelineController: UIViewController = {
            let vc = pages.instantiateViewController(withIdentifier: "StatusesList") as! StatusesListController
            vc.dataSource = HomeTimelineStatusesListControllerDataSource()
            
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Toolbar Status Compose"), style: .plain, target: self, action: #selector(self.composeClicked(_:)))
            vc.navigationItem.title = "Home"
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab Icon Home"), tag: 1)
            nvc.navigationBar.isTranslucent = false
            return nvc
        }()
        
        let notificationsTimelineController: UIViewController = {
            let vc = pages.instantiateViewController(withIdentifier: "ActivitiesList") as! ActivitiesListController
            vc.dataSource = InteractionsActivitiesListControllerDataSource()
            
            vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Toolbar Status Compose"), style: .plain, target: self, action: #selector(self.composeClicked(_:)))
            vc.navigationItem.title = "Notifications"
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "Tab Icon Notification"), tag: 2)
            nvc.navigationBar.isTranslucent = false
            return nvc
        }()
        
        let messageConversationsController: UIViewController = {
            let vc = pages.instantiateViewController(withIdentifier: "StubTab")
            
            vc.navigationItem.title = "Messages"
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Tab Icon Message"), tag: 3)
            nvc.navigationBar.isTranslucent = false
            return nvc
        }()
        
        let profileController: UIViewController = {
            let vc = viewers.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileController
            try! vc.displayUser(user: defaultAccount()!.user, reload: true)
            
            vc.navigationItem.title = "Me"
            
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem = UITabBarItem(title: "Me", image: UIImage(named: "Tab Icon User"), tag: 4)
            nvc.navigationBar.isTranslucent = false
            return nvc
        }()
        
        let pageControllers = [homeTimelineController, notificationsTimelineController, messageConversationsController, profileController]
        
        setViewControllers(pageControllers, animated: false)

        self.tabBar.isTranslucent = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func composeClicked(_ sender: UIBarButtonItem) {
        ComposeController.create().show(parent: self.parent ?? self)
    }
    
    @objc private func accountIconClicked(_ sender: UITapGestureRecognizer) {
        sender.isEnabled = false
        _ = DispatchQueue.global().promise { () -> Account in
            return try defaultAccount()!
            }.then { account -> Void in
                let vc = self.storyboard!.instantiateViewController(withIdentifier: "AccountProfile") as! UserProfileController
                vc.displayUser(user: account.user, reload: true)
                self.show(vc, sender: self)
            }.always {
                sender.isEnabled = true
        }
    }
    
}
