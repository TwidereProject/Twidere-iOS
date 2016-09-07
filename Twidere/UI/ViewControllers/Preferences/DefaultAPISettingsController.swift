//
//  DefaultAPISettingsController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class DefaultAPISettingsController: UITableViewController {

    private var defaultApiConfigs: NSArray!
    var callback: ((CustomAPIConfig) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let path = NSBundle.mainBundle().pathForResource("DefaultAPIConfig", ofType: "plist")
        defaultApiConfigs = NSArray(contentsOfFile: path!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defaultApiConfigs.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Item", forIndexPath: indexPath)

        let dict = defaultApiConfigs[indexPath.row] as! NSDictionary
        cell.textLabel?.text = dict["name"] as? String

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dict = defaultApiConfigs[indexPath.row] as! NSDictionary
        let config = CustomAPIConfig()
        config.apiUrlFormat = dict["apiUrlFormat"] as? String ?? defaultApiUrlFormat
        config.authType = CustomAPIConfig.AuthType(rawValue: dict["authType"] as? String ?? "OAuth") ?? .OAuth
        config.consumerKey = dict["consumerKey"] as? String ?? defaultApiUrlFormat
        config.consumerSecret = dict["consumerSecret"] as? String ?? defaultTwitterConsumerSecret
        config.noVersionSuffix = dict["noVersionSuffix"] as? Bool ?? false
        config.sameOAuthSigningUrl = dict["sameOAuthSigningUrl"] as? Bool ?? true
        self.callback(config)
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
