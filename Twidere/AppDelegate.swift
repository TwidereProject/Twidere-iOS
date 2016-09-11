//
//  AppDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/5/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SQLite
import AttributedLabel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var performingScroll: Bool = false
    var window: UIWindow?
    
    lazy var sqliteDatabase: Connection = {
        let docsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let dbPath = NSURL(fileURLWithPath: docsPath).URLByAppendingPathComponent("twidere.sqlite3")

        let db = try! Connection(dbPath.path!)
        
//        db.trace { print($0) }
        
        let oldVersion = db.userVersion
        if (oldVersion == 0) {
            let migration = DatabaseMigration()
            try! migration.create(db)
            db.userVersion = databaseVersion
        } else if (databaseVersion > oldVersion) {
            let migration = DatabaseMigration()
            try! migration.upgrade(db, oldVersion: oldVersion, newVersion: databaseVersion)
            db.userVersion = databaseVersion
        }
        return db
    }()
    
    lazy var backgroundOperationService: BackgroundOperationService = {
       return BackgroundOperationService()
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.sharedManager().enable = true
        
        UITabBar.appearance().tintColor = materialLightBlue300
        UINavigationBar.appearance().tintColor = materialLightBlue300
        AttributedLabel.appearance().tintColor = materialLightBlue300
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let db = sqliteDatabase
        for account in try! allAccounts() {
            func clearByItemLimit(accountKey: UserKey, limit: Int, table: Table) -> Delete {
                let accountWhere = Status.RowIndices.accountKey == accountKey
                let minId = table.select(Status.RowIndices.positionKey).filter(accountWhere).order(Status.RowIndices.positionKey.desc).limit(1, offset: limit)
                
                
                return table.filter(Status.RowIndices.positionKey < Expression<Int64?>(literal: "(\(minId.asSQL()))") && accountWhere).delete()
            }
            
            let accountKey = account.key!
            
            try! db.transaction {
                try db.run(clearByItemLimit(accountKey, limit: 30, table: homeStatusesTable))
            }
        }
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

