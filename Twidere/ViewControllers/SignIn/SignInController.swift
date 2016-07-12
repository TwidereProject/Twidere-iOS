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
import CoreData
import SugarRecord
import PromiseKit
import SwiftyJSON

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
        switch customAPIConfig.authType {
        case .OAuth:
            doBrowserSignIn()
        case .xAuth:
            doXAuthSignIn()
        case .TwipO:
            doTwipOSignIn()
        case .Basic:
            doBasicSignIn()
        }
        
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
        
        doSignIn { config throws -> SignInResult in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true)
            let authenticator = TwitterOAuthPasswordAuthenticator(endpoint: endpoint, consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret, loginVerificationCallback: { challengeType -> String? in
                    return nil
                }, browserUserAgent: userAgent)
            let accessToken = try authenticator.getOAuthAccessToken(username, password: password)
            let auth = OAuthAuthorization(consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret, oauthToken: accessToken)
                endpoint = apiConfig.createEndpoint("api")
                
            let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
            return SignInResult(user: JSON(microBlog.verifyCredentials().content!))
        }
    }
    
    private func doBrowserSignIn() {
        let endpoint = customAPIConfig.createEndpoint("api", noVersionSuffix: true)
        let auth = OAuthAuthorization(consumerKey: ServiceConstants.defaultTwitterConsumerKey, consumerSecret: ServiceConstants.defaultTwitterConsumerSecret)
        let oauth = OAuthService(endpoint: endpoint, auth: auth)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_promise {
            return try oauth.getRequestToken("oob")
        }.then { token -> Void in
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("BrowserSignIn") as! BrowserSignInController
            vc.customAPIConfig = self.customAPIConfig
            vc.requestToken = token
            vc.callback = self.finishBrowserSignIn
            self.showViewController(vc, sender: self)
        }.always {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }.error { error in
            debugPrint(error)
        }
    }
    
    private func doXAuthSignIn() {
        let username = editUsername.text ?? ""
        let password = editPassword.text ?? ""
        doSignIn { config throws -> SignInResult in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true)
            let oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret))
            let accessToken = try oauth.getAccessToken(username, xauthPassword: password)
            let auth = OAuthAuthorization(consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret, oauthToken: accessToken)
            endpoint = apiConfig.createEndpoint("api")
            let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
            return SignInResult(user: JSON(microBlog.verifyCredentials().content!))
        }
    }
    
    private func doBasicSignIn() {
        let username = editUsername.text ?? ""
        let password = editPassword.text ?? ""
        doSignIn { config -> SignInResult in
            let endpoint = self.customAPIConfig.createEndpoint("api")
            let auth = BasicAuthorization(username: username, password: password)
            let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
            return SignInResult(user: JSON(microBlog.verifyCredentials().content!))
        }
    }
    
    private func doTwipOSignIn() {
        doSignIn { config -> SignInResult in
            let endpoint = self.customAPIConfig.createEndpoint("api")
            let microBlog = MicroBlogService(endpoint: endpoint)
            return SignInResult(user: JSON(microBlog.verifyCredentials().content!))
        }
    }
    
    private func finishBrowserSignIn(requestToken: OAuthToken, oauthVerifier: String?) {
        doSignIn { config throws -> SignInResult in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true)
            let oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret))
            let accessToken = try oauth.getAccessToken(requestToken, oauthVerifier: oauthVerifier)
            let auth = OAuthAuthorization(consumerKey: apiConfig.consumerKey, consumerSecret: apiConfig.consumerSecret, oauthToken: accessToken)
            endpoint = apiConfig.createEndpoint("api")
            let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
            return SignInResult(user: JSON(microBlog.verifyCredentials().content!))
        }
    }
    
    private func doSignIn(action: (config: CustomAPIConfig) throws -> SignInResult) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_promise {
            return try action(config: self.customAPIConfig)
        }.thenInBackground { (result) -> Void in
            debugPrint(result)
        }.always {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }.error { error in
            debugPrint(error)
        }
    }
    
}


class SignInResult {
    var user: JSON
    var accessToken: OAuthToken? = nil
    var username: String? = nil
    var password: String? = nil
    
    init(user: JSON) {
        self.user = user
    }
}
