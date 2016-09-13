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
        
        menuToggleItem.customView?.touchHighlightingStyle = .TransparentMask
        
        let pages = UIStoryboard(name: "Pages", bundle: nil)
        
        let homeTimelineController = pages.instantiateViewControllerWithIdentifier("StatusesList") as! StatusesListController
        homeTimelineController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab Icon Home"), tag: 1)
        homeTimelineController.delegate = HomeTimelineStatusesListControllerDelegate()
        let notificationsTimelineController = pages.instantiateViewControllerWithIdentifier("StubTab")
        notificationsTimelineController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "Tab Icon Notification"), tag: 2)
        let messageConversationsController = pages.instantiateViewControllerWithIdentifier("StubTab")
        messageConversationsController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Tab Icon Message"), tag: 3)
        let testController = pages.instantiateViewControllerWithIdentifier("StatusesList") as! StatusesListController
        testController.delegate = UserTimelineStatusesListControllerDelegate()
        testController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "Tab Icon User"), tag: 4)
        setViewControllers([homeTimelineController, notificationsTimelineController, messageConversationsController, testController], animated: false)
        
    }
    
    override func viewDidLayoutSubviews() {
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
    
    override func viewDidAppear(animated: Bool) {
        let account = try! defaultAccount()!
        accountProfileImageView.displayImage(account.user!.profileImageUrlForSize(.ReasonablySmall), placeholder: UIImage(named: "Profile Image Default"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func composeClicked(sender: UIBarButtonItem) {
        ComposeController.show(self.parentViewController ?? self, identifier: "Compose")
    }
    
    @IBAction func accountIconClicked(sender: UITapGestureRecognizer) {
        let account = try! defaultAccount()!
        let vc = storyboard!.instantiateViewControllerWithIdentifier("AccountProfile") as! UserProfileController
        vc.user = account.user
        navigationController?.showViewController(vc, sender: self)
    }
    
    class HomeTimelineStatusesListControllerDelegate: StatusesListControllerDelegate {
        let table = Table("home_statuses")
        
        func getAccounts() -> [Account] {
            return [try! defaultAccount()!]
        }
        
        func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[Status]> {
            return dispatch_promise { () -> [UserKey] in
                return self.getAccounts().map({ $0.key! })
                }.then{ accountKeys -> Promise<[UserKey]> in
                    return Promise { fullfill, reject in
                        if let params = opts.params where !opts.initLoad {
                            GetStatusesTask.execute(params, table: self.table, fetchAction: { account, microblog, paging -> Promise<[Status]> in
                                return microblog.getHomeTimeline(paging)
                            }).always {
                                fullfill(accountKeys)
                            }
                        } else {
                            fullfill(accountKeys)
                        }
                    }
                }.then({ (accountKeys) -> [Status] in
                    
                    let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
                    return try db.prepare(self.table.filter(accountKeys.contains(Status.RowIndices.accountKey)).order(Status.RowIndices.positionKey.desc)).map { row -> Status in
                        return Status(row: row)
                    }
                })
        }
        
        func getNewestStatusIds(accounts: [Account]) -> [String?]? {
            let accountKeys = accounts.map({ $0.key! })
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
            
            var result = [String?](count: accounts.count, repeatedValue: nil)
            for row in try! db.prepare(table.select(Status.RowIndices.accountKey, Status.RowIndices.id)
                .group(Status.RowIndices.accountKey, having: accountKeys.contains(Status.RowIndices.accountKey))
                .order(Status.RowIndices.createdAt.max)) {
                    if let key = row.get(Status.RowIndices.accountKey), let idx = accountKeys.indexOf({$0 == key}) {
                        result[idx] = row.get(Status.RowIndices.id)
                    }
            }
            return result
        }
        
        func getNewestStatusSortIds(accounts: [Account]) -> [Int64]? {
            let accountKeys = accounts.map({ $0.key! })
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
            
            var result = [Int64](count: accounts.count, repeatedValue: -1)
            for row in try! db.prepare(table.select(Status.RowIndices.accountKey, Status.RowIndices.sortId)
                .group(Status.RowIndices.accountKey, having: accountKeys.contains(Status.RowIndices.accountKey))
                .order(Status.RowIndices.createdAt.max)) {
                    if let key = row.get(Status.RowIndices.accountKey), let idx = accountKeys.indexOf({$0 == key}) {
                        result[idx] = row.get(Status.RowIndices.sortId) ?? -1
                    }
            }
            return result
        }
    }
    
    class UserTimelineStatusesListControllerDelegate: StatusesListControllerDelegate {
        func getAccounts() -> [Account] {
            return [try! defaultAccount()!]
        }
        
        func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[Status]> {
            return dispatch_promise {  () -> [Status] in
                let account = try defaultAccount()!
                let json = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("statuses_list", ofType: "json")!)!)
                return Status.arrayFromJson(json, accountKey: account.key)
            }
        }
        
        func getNewestStatusIds(accounts: [Account]) -> [String?]? {
            return nil
        }
        
        func getNewestStatusSortIds(accounts: [Account]) -> [Int64]? {
            return nil
        }
    }
    
}