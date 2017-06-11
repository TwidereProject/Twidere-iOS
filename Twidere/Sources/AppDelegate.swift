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
import YYText
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow!

    static var performingScroll: Bool = false

    fileprivate(set) lazy var sqliteDatabase: Connection = self.openSQLiteDatabase()

    fileprivate func openSQLiteDatabase() -> Connection {
        let docsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbPath = URL(fileURLWithPath: docsPath).appendingPathComponent("twidere.sqlite3")

        let db = try! Connection(dbPath.path)

        let oldVersion = db.userVersion
//        if (oldVersion == 0) {
//            let migration = DatabaseMigration()
//            try! migration.create(db)
//            db.userVersion = databaseVersion
//        } else if (databaseVersion > oldVersion) {
//            let migration = DatabaseMigration()
//            try! migration.upgrade(db, oldVersion: oldVersion, newVersion: databaseVersion)
//            db.userVersion = databaseVersion
//        }
        return db
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])

        let keyboardManager = IQKeyboardManager.sharedManager()
        keyboardManager.enable = true
//        keyboardManager.disabledToolbarClasses.append(ComposeController.self)


        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = MainViewController()

        window.backgroundColor = UIColor.white
        window.rootViewController = vc
        window.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let db = sqliteDatabase

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

}

