//
//  DefaultAPISettingsController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class DefaultAPISettingsController: UITableViewController {
    
    fileprivate var defaultApiConfigs: NSArray!
    var callback: ((CustomAPIConfig) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let path = Bundle.main.path(forResource: "DefaultAPIConfig", ofType: "plist")
        defaultApiConfigs = NSArray(contentsOfFile: path!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return defaultApiConfigs.count
        default: return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        switch (indexPath as NSIndexPath).section {
        case 0:
            cell.textLabel?.text = "Default"
        case 1:
            let dict = defaultApiConfigs[(indexPath as NSIndexPath).item] as! NSDictionary
            cell.textLabel?.text = dict["name"] as? String
        default: break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let config = CustomAPIConfig()
        switch (indexPath as NSIndexPath).section {
        case 0:
            config.loadDefaults()
        case 1:
            let dict = defaultApiConfigs[(indexPath as NSIndexPath).item] as! NSDictionary
            config.apiUrlFormat = dict["apiUrlFormat"] as? String ?? defaultApiUrlFormat
            config.authType = CustomAPIConfig.AuthType(rawValue: dict["authType"] as? String ?? "OAuth") ?? .OAuth
            config.consumerKey = dict["consumerKey"] as? String ?? defaultApiUrlFormat
            config.consumerSecret = dict["consumerSecret"] as? String ?? defaultTwitterConsumerSecret
            config.noVersionSuffix = dict["noVersionSuffix"] as? Bool ?? false
            config.sameOAuthSigningUrl = dict["sameOAuthSigningUrl"] as? Bool ?? true
        default: break
        }
        self.callback(config)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
}
