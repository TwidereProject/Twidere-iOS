//
//  APIEditorViewController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import StaticDataTableViewController

class APIEditorController: StaticDataTableViewController {
    
    let authTypeEntries: [String] = ["OAuth", "xAuth", "Basic", "TWIP O mode"]
    let authTypeValues: [CustomAPIConfig.AuthType] = [.OAuth, .xAuth, .Basic, .TwipO]
    
    @IBOutlet weak var editApiUrlFormat: UITextField!
    @IBOutlet weak var editSameOauthSigningUrl: UISwitch!
    @IBOutlet weak var editNoVersionSuffix: UISwitch!
    @IBOutlet weak var editConsumerKey: UITextField!
    @IBOutlet weak var editConsumerSecret: UITextField!
    
    @IBOutlet weak var authTypeCell: UITableViewCell!
    @IBOutlet weak var sameOauthSigningUrlCell: UITableViewCell!
    @IBOutlet weak var consumerKeyCell: UITableViewCell!
    @IBOutlet weak var consumerSecretCell: UITableViewCell!
    
    @IBOutlet weak var authTypeDetails: UILabel!
    
    var customAPIConfig = CustomAPIConfig()
    var callback: ((CustomAPIConfig) -> Void)? = nil
    
    private var authType: CustomAPIConfig.AuthType = .OAuth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        updateOptions(initialSelection)
        
        authType = customAPIConfig.authType
        
        editApiUrlFormat.text = customAPIConfig.apiUrlFormat
        editSameOauthSigningUrl.on = customAPIConfig.sameOAuthUrl
        editNoVersionSuffix.on = customAPIConfig.noVersionSuffix
        editConsumerKey.text = customAPIConfig.consumerKey
        editConsumerSecret.text = customAPIConfig.consumerSecret
        
        if (callback != nil) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.cancelEditAPI))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.finishEditAPI))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "FinishEditAPI"?:
            saveAPISettings()
        default: break
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if (cell != nil) {
            switch cell! {
            case authTypeCell:
                openEditAuthType(cell!)
            default: break
            }
        }
    }
    
    internal func cancelEditAPI() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    internal func finishEditAPI() {
        saveAPISettings()
        callback?(customAPIConfig)
        navigationController?.popViewControllerAnimated(true)
    }
    
    private func saveAPISettings() {
        customAPIConfig.apiUrlFormat = editApiUrlFormat.text ?? ""
        customAPIConfig.authType = authType
        customAPIConfig.consumerKey = editConsumerKey.text ?? ""
        customAPIConfig.consumerSecret = editConsumerSecret.text ?? ""
        customAPIConfig.noVersionSuffix = editNoVersionSuffix.on
        customAPIConfig.sameOAuthUrl = editSameOauthSigningUrl.on
    }
    
    private func openEditAuthType(sender: AnyObject) {
        view.endEditing(true)
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        ActionSheetStringPicker.showPickerWithTitle("Auth Type", rows: authTypeEntries, initialSelection: initialSelection, doneBlock: { picker, index, value in
            self.authType = self.authTypeValues[index]
            self.updateOptions(index)
        }, cancelBlock: { _ in }, origin: sender)
    }
    
    private func updateOptions(index: Int) {
        self.authTypeDetails.text = authTypeEntries[index]
        
        hideSectionsWithHiddenRows = true
        
        let isOAuthType = self.customAPIConfig.authType.isOAuthType
        cell(sameOauthSigningUrlCell, setHidden: !isOAuthType)
        cell(consumerKeyCell, setHidden: !isOAuthType)
        cell(consumerSecretCell, setHidden: !isOAuthType)
        
        reloadDataAnimated(true)
    }
}
