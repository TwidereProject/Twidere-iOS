//
//  HomeDrawerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class HomeDrawerController: UITableViewController {

    private let SECTION_ACCOUNT_ACTION = 0
    private let SECTION_SEPARATOR = 1
    private let SECTION_APP_MENU_ACTION = 2
    
    let accountActions = ["Search", "Favorites", "Lists"]
    
    @IBOutlet weak var accountProfileImageView: UIImageView!
    @IBOutlet weak var accountProfileBannerView: UIImageView!
    @IBOutlet weak var accountNameView: UILabel!
    @IBOutlet weak var accountScreenNameView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let account = try! defaultAccount()!
        let user = account.user!
        
        accountNameView.text = user.name
        accountScreenNameView.text = "@\(user.screenName!)"
        
        accountProfileImageView.displayImage(user.profileImageUrl, placeholder: UIImage(named: "Profile Image Default"))
        accountProfileBannerView.displayImage(user.profileBannerUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case SECTION_ACCOUNT_ACTION:
            return accountActions.count
        case SECTION_SEPARATOR:
            return 1
        case SECTION_APP_MENU_ACTION:
            return AppMenuAction.all.count
        default: break
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case SECTION_ACCOUNT_ACTION:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuItem", forIndexPath: indexPath)
            cell.textLabel?.text = accountActions[indexPath.item]
            return cell
        case SECTION_SEPARATOR:
            let cell = tableView.dequeueReusableCellWithIdentifier("Separator", forIndexPath: indexPath)
            return cell
        case SECTION_APP_MENU_ACTION:
            let cell = tableView.dequeueReusableCellWithIdentifier("MenuItem", forIndexPath: indexPath)
            cell.textLabel?.text = AppMenuAction.all[indexPath.item].title
            return cell
        default: break
        }

        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch (indexPath.section) {
        case SECTION_ACCOUNT_ACTION:
            break
        case SECTION_APP_MENU_ACTION:
            switch AppMenuAction.all[indexPath.item] {
            case .Accounts:
                performSegueWithIdentifier("ShowAccounts", sender: self)
            case .Settings:
                performSegueWithIdentifier("OpenPreferences", sender: self)
            default:
                break
            }
        default: break
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    enum AppMenuAction {
        case Accounts, Filters, Drafts, Settings
        
        var title: String {
            get {
                switch self {
                case .Accounts:
                    return "Accounts"
                case .Filters:
                    return "Filters"
                case .Drafts:
                    return "Drafts"
                case .Settings:
                    return "Settings"
                }
            }
        }
        
        static let all = [Accounts, Filters, Drafts, Settings]
    }

}
