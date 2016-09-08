//
//  HomeViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SDWebImage
import SugarRecord
import UIView_TouchHighlighting
import REFrostedViewController
import Pager
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
        
        let homeTimelineController = StatusesListController(nibName: "StatusesListController", bundle: nil)
        homeTimelineController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Tab Icon Home"), tag: 1)
        homeTimelineController.delegate = HomeTimelineStatusesListControllerDelegate()
        let notificationsTimelineController = storyboard!.instantiateViewControllerWithIdentifier("StubTab")
        notificationsTimelineController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(named: "Tab Icon Notification"), tag: 2)
        let messageConversationsController = storyboard!.instantiateViewControllerWithIdentifier("StubTab")
        messageConversationsController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Tab Icon Message"), tag: 3)
        let testController = StatusesListController(nibName: "StatusesListController", bundle: nil)
        testController.delegate = UserTimelineStatusesListControllerDelegate()
        testController.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "Tab Icon User"), tag: 4)
        setViewControllers([homeTimelineController, notificationsTimelineController, messageConversationsController, testController], animated: false)

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
    
    @IBAction func menuToggleClicked(sender: UITapGestureRecognizer) {
        frostedViewController.presentMenuViewController()
    }
    
    @IBAction func panGestureRecognized(sender: UIScreenEdgePanGestureRecognizer) {
        frostedViewController.panGestureRecognized(sender)
    }
    
    class HomeTimelineStatusesListControllerDelegate: StatusesListControllerDelegate {
        let table = Table("home_statuses")
        
        func getAccounts() -> [Account] {
            return [try! defaultAccount()!]
        }
        
        func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[FlatStatus]> {
            return dispatch_promise {  () -> [FlatStatus] in
                let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
                
                if let params = opts.params where !opts.initLoad {
                    GetStatusesTask.execute(params, table: self.table) { account, microblog, paging -> [FlatStatus] in
                        return FlatStatus.arrayFromJson(try microblog.getHomeTimeline(paging), account: account)
                    }
                }
                let accountKeys = self.getAccounts().map({ UserKey(rawValue: $0.accountKey!) })
                
                return try db.prepare(self.table.filter(accountKeys.contains(FlatStatus.RowIndices.accountKey)).order(FlatStatus.RowIndices.positionKey.desc)).map { row -> FlatStatus in
                    return FlatStatus(row: row)
                }
            }
        }
        
        func getNewestStatusIds(accounts: [Account]) -> [String?]? {
            let accountKeys = accounts.map({ UserKey(rawValue: $0.accountKey!) })
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
            
            var result = [String?](count: accounts.count, repeatedValue: nil)
            for row in try! db.prepare(table.select(FlatStatus.RowIndices.accountKey, FlatStatus.RowIndices.id)
                .group(FlatStatus.RowIndices.accountKey, having: accountKeys.contains(FlatStatus.RowIndices.accountKey))
                .order(FlatStatus.RowIndices.createdAt.max)) {
                    if let key = row.get(FlatStatus.RowIndices.accountKey), let idx = accountKeys.indexOf({$0 == key}) {
                        result[idx] = row.get(FlatStatus.RowIndices.id)
                    }
            }
            return result
        }
        
        func getNewestStatusSortIds(accounts: [Account]) -> [Int64]? {
            let accountKeys = accounts.map({ UserKey(rawValue: $0.accountKey!) })
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
            
            var result = [Int64](count: accounts.count, repeatedValue: -1)
            for row in try! db.prepare(table.select(FlatStatus.RowIndices.accountKey, FlatStatus.RowIndices.sortId)
                .group(FlatStatus.RowIndices.accountKey, having: accountKeys.contains(FlatStatus.RowIndices.accountKey))
                .order(FlatStatus.RowIndices.createdAt.max)) {
                    if let key = row.get(FlatStatus.RowIndices.accountKey), let idx = accountKeys.indexOf({$0 == key}) {
                        result[idx] = row.get(FlatStatus.RowIndices.sortId) ?? -1
                    }
            }
            return result
        }
    }
    
    class UserTimelineStatusesListControllerDelegate: StatusesListControllerDelegate {
        func getAccounts() -> [Account] {
            return [try! defaultAccount()!]
        }
        
        func loadStatuses(opts: StatusesListController.LoadOptions) -> Promise<[FlatStatus]> {
            return dispatch_promise {  () -> [FlatStatus] in
                let account = try defaultAccount()!
                let json = JSON(data: NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("statuses_list", ofType: "json")!)!)
                return FlatStatus.arrayFromJson(json, account: account)
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