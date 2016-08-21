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
    
    @IBOutlet weak var loadDefaultCell: UITableViewCell!
    @IBOutlet weak var authTypeCell: UITableViewCell!
    @IBOutlet weak var sameOauthSigningUrlCell: UITableViewCell!
    @IBOutlet weak var consumerKeyCell: UITableViewCell!
    @IBOutlet weak var consumerSecretCell: UITableViewCell!
    
    @IBOutlet weak var authTypeDetails: UILabel!
    
    var customAPIConfig = CustomAPIConfig()
    var callback: ((CustomAPIConfig) -> Void)? = nil
    var disappearCallback: ((CustomAPIConfig) -> Void)? = nil
    
    private var authType: CustomAPIConfig.AuthType = .OAuth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSectionsWithHiddenRows = true
        
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        updateOptions(initialSelection)
        
        authType = customAPIConfig.authType
        
        updateView()
        
        if (callback != nil) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.cancelEditAPI))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.finishEditAPI))
        }
        
        cell(loadDefaultCell, setHidden: callback == nil)
        reloadDataAnimated(false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveAPISettings()
        disappearCallback?(customAPIConfig)
        super.viewWillDisappear(animated)
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
        case "LoadDefaultAPIConfig"?:
            let dest = segue.destinationViewController as! DefaultAPISettingsController
            dest.callback = { config in
                self.authType = config.authType
                self.customAPIConfig = config
                self.updateView()
            }
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
        customAPIConfig.sameOAuthSigningUrl = editSameOauthSigningUrl.on
    }
    
    private func openEditAuthType(sender: AnyObject) {
        view.endEditing(true)
        let initialSelection = authTypeValues.indexOf(customAPIConfig.authType) ?? 0
        let picker = ActionSheetStringPicker.showPickerWithTitle("Auth Type", rows: authTypeEntries, initialSelection: initialSelection, doneBlock: self.authTypeSelected, cancelBlock: { _ in }, origin: sender)
        picker.tapDismissAction = .Cancel
    }
    
    private func authTypeSelected(picker: ActionSheetStringPicker!, index: Int, value: AnyObject!) {
        self.authType = self.authTypeValues[index]
        self.updateOptions(index)
    }
    
    private func updateOptions(index: Int) {
        
        authTypeDetails.text = authTypeEntries[index]
        
        hideSectionsWithHiddenRows = true
        
        let isOAuthType = self.customAPIConfig.authType.isOAuthType
        cell(sameOauthSigningUrlCell, setHidden: !isOAuthType)
        cell(consumerKeyCell, setHidden: !isOAuthType)
        cell(consumerSecretCell, setHidden: !isOAuthType)
        
        reloadDataAnimated(true)
    }
    
    private func updateView() {
        editApiUrlFormat.text = customAPIConfig.apiUrlFormat
        editSameOauthSigningUrl.on = customAPIConfig.sameOAuthSigningUrl
        editNoVersionSuffix.on = customAPIConfig.noVersionSuffix
        editConsumerKey.text = customAPIConfig.consumerKey
        editConsumerSecret.text = customAPIConfig.consumerSecret
        authTypeDetails.text = authTypeEntries[authTypeValues.indexOf(authType) ?? 0]
    }
}
