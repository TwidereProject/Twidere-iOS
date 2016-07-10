//
//  SignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var hasCancel: Bool = false
    
    // MARK: Properties
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernamePasswordContainer: UIStackView!
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var signUpSignInContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup button colors
        signUpButton.layer.borderColor = signUpButton.tintColor.CGColor
        loginButton.tintColor = UIConstants.materialLightGreen
        loginButton.layer.borderColor = UIConstants.materialLightGreen.CGColor
        
        let settingsItem = UIBarButtonItem(image: UIImage(named: "Toolbar Settings"), style: .Plain, target: self, action: #selector(self.settingsClicked))
        
        navigationItem.rightBarButtonItem = settingsItem
        
        if (hasCancel) {
            let cancelItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.closeSignIn))
            navigationItem.leftBarButtonItem = cancelItem
        }
    }
    
    @IBAction func signInClicked(sender: UIButton) {
        let endpoint = OAuthEndpoint(base: "https://api.twitter.com/")
        let auth = OAuthAuthorization(consumerKey: ServiceConstants.defaultTwitterConsumerKey, consumerSecret: ServiceConstants.defaultTwitterConsumerSecret)
        let oauth = OAuthService(endpoint: endpoint, auth: auth)
        oauth.getRequestToken("oob") { (token, error) -> Void in
            debugPrint("token: \(token), error: \(error)")
        }
    }
    
    func closeSignIn() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func settingsClicked() {
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
}
