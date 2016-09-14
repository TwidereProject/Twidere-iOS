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
    
    fileprivate var authType: CustomAPIConfig.AuthType = .OAuth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideSectionsWithHiddenRows = true
        
        let initialSelection = authTypeValues.index(of: customAPIConfig.authType) ?? 0
        updateOptions(initialSelection)
        
        authType = customAPIConfig.authType
        
        updateView()
        
        if (callback != nil) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelEditAPI))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.finishEditAPI))
        }
        
        cell(loadDefaultCell, setHidden: callback == nil)
        reloadData(animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "FinishEditAPI"?:
            saveAPISettings()
        case "LoadDefaultAPIConfig"?:
            let dest = segue.destination as! DefaultAPISettingsController
            dest.callback = { config in
                self.authType = config.authType
                self.customAPIConfig = config
                self.updateView()
            }
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        if (cell != nil) {
            switch cell! {
            case authTypeCell:
                openEditAuthType(cell!)
            default: break
            }
        }
    }
    
    internal func cancelEditAPI() {
        navigationController?.popViewController(animated: true)
    }
    
    internal func finishEditAPI() {
        saveAPISettings()
        callback?(customAPIConfig)
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func saveAPISettings() {
        customAPIConfig.apiUrlFormat = editApiUrlFormat.text ?? ""
        customAPIConfig.authType = authType
        customAPIConfig.consumerKey = editConsumerKey.text ?? ""
        customAPIConfig.consumerSecret = editConsumerSecret.text ?? ""
        customAPIConfig.noVersionSuffix = editNoVersionSuffix.isOn
        customAPIConfig.sameOAuthSigningUrl = editSameOauthSigningUrl.isOn
    }
    
    fileprivate func openEditAuthType(_ sender: AnyObject) {
        view.endEditing(true)
        let initialSelection = authTypeValues.index(of: customAPIConfig.authType) ?? 0
        let picker = ActionSheetStringPicker.show(withTitle: "Auth Type", rows: authTypeEntries, initialSelection: initialSelection, doneBlock: self.authTypeSelected, cancel: { _ in }, origin: sender)
        picker.tapDismissAction = .cancel
    }
    
    fileprivate func authTypeSelected(_ picker: ActionSheetStringPicker!, index: Int, value: AnyObject!) {
        self.authType = self.authTypeValues[index]
        self.updateOptions(index)
    }
    
    fileprivate func updateOptions(_ index: Int) {
        
        authTypeDetails.text = authTypeEntries[index]
        
        hideSectionsWithHiddenRows = true
        
        let isOAuthType = self.customAPIConfig.authType.isOAuthType
        cell(sameOauthSigningUrlCell, setHidden: !isOAuthType)
        cell(consumerKeyCell, setHidden: !isOAuthType)
        cell(consumerSecretCell, setHidden: !isOAuthType)
        
        reloadData(animated: true)
    }
    
    fileprivate func updateView() {
        editApiUrlFormat.text = customAPIConfig.apiUrlFormat
        editSameOauthSigningUrl.isOn = customAPIConfig.sameOAuthSigningUrl
        editNoVersionSuffix.isOn = customAPIConfig.noVersionSuffix
        editConsumerKey.text = customAPIConfig.consumerKey
        editConsumerSecret.text = customAPIConfig.consumerSecret
        authTypeDetails.text = authTypeEntries[authTypeValues.index(of: authType) ?? 0]
    }
}
