//
//  SignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit
import Async
import SwiftyUserDefaults

class SignInController: UIViewController {
    
    var hasCancel: Bool = false
    var customAPIConfig: CustomAPIConfig = CustomAPIConfig()
    
    // MARK: Properties
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordSignInButton: UIButton!
    @IBOutlet weak var usernamePasswordContainer: UIView!
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var signUpSignInContainer: UIStackView!
    
    @IBOutlet weak var cancelItem: UIBarButtonItem!
    
    @IBOutlet weak var showUsernamePasswordConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideUsernamePasswordConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var hidePasswordSignInButtonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup button colors
        signUpButton.layer.borderColor = signUpButton.tintColor.CGColor
        loginButton.tintColor = UIConstants.materialLightGreen
        loginButton.layer.borderColor = UIConstants.materialLightGreen.CGColor
        
        cancelItem.enabled = hasCancel
        
        customAPIConfig.loadDefaults()
        
        updateSignInUi()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "ShowAPIEditor"?:
            let dest = segue.destinationViewController as! APIEditorController
            dest.customAPIConfig = customAPIConfig
            dest.callback = { config in
                self.customAPIConfig = config
                self.updateSignInUi()
            }
        default: break
        }
    }

    
    @IBAction func unwindFromPasswordSignIn(segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "DoPasswordSignIn"?:
            let vc = segue.sourceViewController as! PasswordSignInController
            let (username, password) = vc.usernamePassword
            doOAuthPasswordSignIn(username, password: password)
        default: break
        }
    }
    
    @IBAction func signInClicked(sender: UIButton) {
        let endpoint = OAuthEndpoint(base: "https://api.twitter.com/")
        let auth = OAuthAuthorization(consumerKey: ServiceConstants.defaultTwitterConsumerKey, consumerSecret: ServiceConstants.defaultTwitterConsumerSecret)
        let oauth = OAuthService(endpoint: endpoint, auth: auth)
        try! oauth.getRequestToken("oob") { (token, error) in
            debugPrint("token: \(token), error: \(error)")
        }
    }
    
    @IBAction func passwordSignInClicked(sender: UIButton) {
        performSegueWithIdentifier("ShowPasswordSignIn", sender: self)
    }
    
    @IBAction func cancelSignIn(sender: UIBarButtonItem) {
    }
    
    @IBAction func openSettingsMenu(sender: UIBarButtonItem) {
        let actionSheet: UIAlertController = UIAlertController(title: "Settings", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        let saveAction: UIAlertAction = UIAlertAction(title: "Edit API", style: .Default) { action -> Void in
            self.performSegueWithIdentifier("ShowAPIEditor", sender: self)
        }
        actionSheet.addAction(saveAction)
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Settings", style: .Default) { action -> Void in
            self.performSegueWithIdentifier("ShowPreferences", sender: self)
        }
        actionSheet.addAction(deleteAction)
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    private func updateSignInUi() {
        if (customAPIConfig.authType == .OAuth) {
            passwordSignInButton.hidden = false
            hidePasswordSignInButtonConstraint.active = false
        } else {
            passwordSignInButton.hidden = true
            hidePasswordSignInButtonConstraint.active = true
        }
        if (customAPIConfig.authType.usePassword) {
            usernamePasswordContainer.hidden = false
            
            hideUsernamePasswordConstraint.active = false
            showUsernamePasswordConstraint.active = true
            
            signUpSignInContainer.axis = .Horizontal
        } else {
            
            usernamePasswordContainer.hidden = true
            
            hideUsernamePasswordConstraint.active = true
            showUsernamePasswordConstraint.active = false
            
            signUpSignInContainer.axis = .Vertical
        }
    }
    
    private func doOAuthPasswordSignIn(username: String, password: String) {
        let userAgent = UIWebView().stringByEvaluatingJavaScriptFromString("navigator.userAgent")
            
        let apiConfig = self.customAPIConfig
        let endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true)
        let authenticator = TwitterOAuthPasswordAuthenticator(endpoint: endpoint, consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret, loginVerificationCallback: { challengeType -> String? in
                return nil
            }, browserUserAgent: userAgent)
            
        authenticator.getOAuthAccessToken(username, password: password) { result, error in
        }
    }
    
}
