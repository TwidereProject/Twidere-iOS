//
//  APIEditorViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class APIEditorController: UITableViewController {
    
    let authTypeEntries: [String] = ["OAuth", "xAuth", "Basic", "TWIP O mode"]
    let authTypeValues: [CustomAPIConfig.AuthType] = [.OAuth, .xAuth, .Basic, .TwipO]
    
    @IBOutlet weak var editApiUrlFormat: UITextField!
    @IBOutlet weak var editSameOauthSigningUrl: UISwitch!
    @IBOutlet weak var editNoVersionSuffix: UISwitch!
    @IBOutlet weak var editConsumerKey: UITextField!
    @IBOutlet weak var editConsumerSecret: UITextField!
    @IBOutlet weak var editAuthType: UITableViewCell!
    
    @IBOutlet weak var authTypeDetails: UILabel!
    
    var customAPIConfig = CustomAPIConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.closeAPIEditor))
        navigationItem.leftBarButtonItem = cancelItem
        let doneItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.saveAPISettings))
        navigationItem.rightBarButtonItem = doneItem
        
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        self.authTypeDetails.text = authTypeEntries[initialSelection]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell != nil) {
            switch cell! {
            case editAuthType:
                openEditAuthType(cell!)
            default: break
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    func closeAPIEditor() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveAPISettings() {
      
    }
    
    func openEditAuthType(sender: AnyObject) {
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        ActionSheetStringPicker.showPickerWithTitle("Auth Type", rows: authTypeEntries, initialSelection: initialSelection, doneBlock: { picker, index, value in
            self.authTypeDetails.text = self.authTypeEntries[index]
            self.customAPIConfig.authType = self.authTypeValues[index]
        }, cancelBlock: { _ in }, origin: sender)
    }
}
