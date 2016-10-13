//
//  SignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import CoreData
import PromiseKit
import SwiftyJSON
import ALSLayouts

class SignInController: UIViewController {
    
    var customAPIConfig: CustomAPIConfig = CustomAPIConfig()
    
    // MARK: Properties
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordSignInButton: UIButton!
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var signInContainer: ALSLinearLayout!
    @IBOutlet weak var signUpSignInContainer: ALSLinearLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup button colors
        signUpButton.layer.borderColor = signUpButton.tintColor.cgColor
        loginButton.tintColor = materialLightGreen
        loginButton.layer.borderColor = materialLightGreen.cgColor
        
        customAPIConfig.loadDefaults()
        
        updateSignInUi()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowAPIEditor"?:
            let dest = segue.destination as! APIEditorController
            dest.customAPIConfig = customAPIConfig
            dest.callback = { config in
                self.customAPIConfig = config
                self.updateSignInUi()
            }
        default: break
        }
    }
    
    @IBAction func unwindFromPasswordSignIn(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "DoPasswordSignIn"?:
            let vc = segue.source as! PasswordSignInController
            let (username, password) = vc.usernamePassword
            doOAuthPasswordSignIn(username, password: password)
        default: break
        }
    }
    
    @IBAction func signInClicked(_ sender: UIButton) {
        switch customAPIConfig.authType {
        case .oauth:
            doBrowserSignIn()
        case .xAuth:
            doXAuthSignIn()
        case .twipO:
            doTwipOSignIn()
        case .basic:
            doBasicSignIn()
        }
        
    }
    
    @IBAction func cancelSignIn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openSettingsMenu(_ sender: UIBarButtonItem) {
        let actionSheet: UIAlertController = UIAlertController(title: "Settings", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        let saveAction: UIAlertAction = UIAlertAction(title: "Edit API", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "ShowAPIEditor", sender: self)
        }
        actionSheet.addAction(saveAction)
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Settings", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "ShowPreferences", sender: self)
        }
        actionSheet.addAction(deleteAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    fileprivate func updateSignInUi() {
        if (customAPIConfig.authType == .oauth) {
            passwordSignInButton.layoutParams.hidden = false
        } else {
            passwordSignInButton.layoutParams.hidden = true
        }
        if (customAPIConfig.authType.usePassword) {
            editUsername.layoutParams.hidden = false
            editPassword.layoutParams.hidden = false
            
            signUpSignInContainer.orientation = .Horizontal
        } else {
            editUsername.layoutParams.hidden = true
            editPassword.layoutParams.hidden = true
            
            signUpSignInContainer.orientation = .Vertical
        }
        signInContainer.setNeedsLayout()
    }
    
    fileprivate func doBrowserSignIn() {
        let apiConfig = self.customAPIConfig
        let endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true, fixUrl: SignInController.fixSignInUrl)
        let auth = OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!)
        let oauth = OAuthService(endpoint: endpoint, auth: auth)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        oauth.getRequestToken("oob").then { token -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowserSignIn") as! BrowserSignInController
            vc.customAPIConfig = self.customAPIConfig
            vc.requestToken = token
            vc.callback = self.finishBrowserSignIn
            self.show(vc, sender: self)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }.catch { error in
                debugPrint(error)
        }
    }
    
    fileprivate func doOAuthPasswordSignIn(_ username: String, password: String) {
        let userAgent = UIWebView().stringByEvaluatingJavaScript(from: "navigator.userAgent")
        
        doSignIn { config -> Promise<SignInResult> in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true)
            let authenticator = TwitterOAuthPasswordAuthenticator(endpoint: endpoint, consumerKey: apiConfig.consumerKey!, consumerSecret: apiConfig.consumerSecret!, loginVerificationCallback: { challengeType -> String? in
                let sem = DispatchSemaphore(value: 0)
                let vc = UIAlertController(title: "Login verification", message: "[Verification message here]", preferredStyle: .alert)
                var challangeResponse: String? = nil
                vc.addTextField{ textField in
                    textField.keyboardType = .emailAddress
                }
                vc.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    challangeResponse = vc.textFields?[0].text
                    sem.signal()
                }))
                vc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                _ = sem.wait(timeout: DispatchTime.distantFuture)
                return challangeResponse
                }, browserUserAgent: userAgent)
            return authenticator.getOAuthAccessToken(username, password: password)
                .then { accessToken -> Promise<SignInResult> in
                    return Promise { fullfull, reject in
                        
                        let auth = OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!, oauthToken: accessToken)
                        endpoint = apiConfig.createEndpoint("api")
                        
                        let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
                        microBlog.verifyCredentials().then { user -> Void in
                            fullfull(SignInResult(user: user, accessToken: accessToken))
                            }.catch { error -> Void in
                                reject(error)
                        }
                    }
            }
        }
    }
    
    fileprivate func doXAuthSignIn() {
        let username = editUsername.text ?? ""
        let password = editPassword.text ?? ""
        doSignIn { config -> Promise<SignInResult> in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true, fixUrl: SignInController.fixSignInUrl)
            let oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!))
            return oauth.getAccessToken(username, xauthPassword: password)
                .then { accessToken -> Promise<SignInResult> in
                    return Promise { fullfull, reject in
                        
                        let auth = OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!, oauthToken: accessToken)
                        endpoint = apiConfig.createEndpoint("api")
                        
                        let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
                        microBlog.verifyCredentials().then { user -> Void in
                            fullfull(SignInResult(user: user, accessToken: accessToken))
                            }.catch { error -> Void in
                                reject(error)
                        }
                    }
            }
        }
    }
    
    fileprivate func doBasicSignIn() {
        let username = editUsername.text ?? ""
        let password = editPassword.text ?? ""
        doSignIn { config -> Promise<SignInResult> in
            let endpoint = self.customAPIConfig.createEndpoint("api")
            let auth = BasicAuthorization(username: username, password: password)
            let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
            return microBlog.verifyCredentials().then { user -> SignInResult in
                return SignInResult(user: user, username: username, password: password)
            }
        }
    }
    
    fileprivate func doTwipOSignIn() {
        doSignIn { config -> Promise<SignInResult> in
            let endpoint = self.customAPIConfig.createEndpoint("api")
            let microBlog = MicroBlogService(endpoint: endpoint)
            return microBlog.verifyCredentials().then { user -> SignInResult in
                return SignInResult(user: user)
            }
        }
    }
    
    fileprivate func finishBrowserSignIn(_ requestToken: OAuthToken, oauthVerifier: String?) {
        doSignIn { config -> Promise<SignInResult> in
            let apiConfig = self.customAPIConfig
            var endpoint = apiConfig.createEndpoint("api", noVersionSuffix: true, fixUrl: SignInController.fixSignInUrl)
            let oauth = OAuthService(endpoint: endpoint, auth: OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!))
            return oauth.getAccessToken(requestToken, oauthVerifier: oauthVerifier)
                .then { accessToken -> Promise<SignInResult> in
                    return Promise { fullfull, reject in
                        
                        let auth = OAuthAuthorization(apiConfig.consumerKey!, apiConfig.consumerSecret!, oauthToken: accessToken)
                        endpoint = apiConfig.createEndpoint("api")
                        
                        let microBlog = MicroBlogService(endpoint: endpoint, auth: auth)
                        microBlog.verifyCredentials().then { user -> Void in
                            fullfull(SignInResult(user: user, accessToken: accessToken))
                            }.catch { error -> Void in
                                reject(error)
                        }
                    }
            }
        }
    }
    
    fileprivate func doSignIn(_ action: (_ config: CustomAPIConfig) -> Promise<SignInResult>) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        action(self.customAPIConfig).then(on: DispatchQueue.global()) { result throws -> Account in
            let user = result.user
            let config = self.customAPIConfig
            let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
            let account = Account(_id: -1, key: user.key, type: .twitter, apiUrlFormat: config.apiUrlFormat, authType: config.authType, basicPassword: result.username, basicUsername: result.password, consumerKey: config.consumerKey, consumerSecret: config.consumerSecret, noVersionSuffix: config.noVersionSuffix, oauthToken: result.accessToken?.oauthToken, oauthTokenSecret: result.accessToken?.oauthTokenSecret, sameOAuthSigningUrl: config.sameOAuthSigningUrl, config: nil, user: user)
            try db.transaction {
                try _ = db.run(Account.insertData(table: accountsTable, model: account))
            }
            return account
        }.then { result -> Void in
            let home = self.storyboard!.instantiateViewController(withIdentifier: "Main")
            self.present(home, animated: true, completion: nil)
        }.always {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }.catch { error in
            if (error is AuthenticationError) {
                switch (error) {
                case AuthenticationError.accessTokenFailed:
                    let vc = UIAlertController(title: nil, message: "Unable to get access token", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                case AuthenticationError.requestTokenFailed:
                    let vc = UIAlertController(title: nil, message: "Unable to get request token", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                case AuthenticationError.wrongUsernamePassword:
                    let vc = UIAlertController(title: nil, message: "Wrong username or password", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                case AuthenticationError.verificationFailed:
                    let vc = UIAlertController(title: nil, message: "Verification failed", preferredStyle: .alert)
                    self.present(vc, animated: true, completion: nil)
                default: break
                }
            }
            debugPrint(error)
        }
    }
    
    static func fixSignInUrl(_ url: String) -> String {
        guard var urlComponents = URLComponents(string: url) else {
            return url
        }
        if ("api.fanfou.com" == urlComponents.host) {
            if (urlComponents.path.hasPrefix("/oauth/")) {
                urlComponents.host = "fanfou.com"
            }
        }
        return urlComponents.string ?? url
    }
}


class SignInResult {
    var user: User
    var accessToken: OAuthToken? = nil
    var username: String? = nil
    var password: String? = nil
    
    init(user: User) {
        self.user = user
    }
    
    init(user: User, accessToken: OAuthToken) {
        self.user = user
        self.accessToken = accessToken
    }
    
    init(user: User, username: String, password: String) {
        self.user = user
        self.username = username
        self.password = password
    }
}
