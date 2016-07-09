//
//  SignInController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/8.
//  Copyright © 2016 Mariotaku Dev. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    var hasCancel: Bool = false
    
    // MARK: Properties
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelItem: UIBarButtonItem!
    @IBOutlet weak var usernamePasswordContainer: UIStackView!
    @IBOutlet weak var editUsername: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var signUpSignInContainer: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup button colors
        signUpButton.layer.borderColor = signUpButton.tintColor.CGColor
        loginButton.tintColor = materialLightGreen
        loginButton.layer.borderColor = materialLightGreen.CGColor
        
        // Hide cancel button if needed
        cancelItem.enabled = hasCancel
        
    }
    
    @IBAction func signInClicked(sender: UIButton) {
        let endpoint = OAuthEndpoint(base: "https://api.twitter.com/1.1/", signingBase: "https://api.twitter.com/1.1/")
        let auth = OAuthAuthorization()
        let twitter = MicroBlogService(endpoint: endpoint, auth: auth)
        twitter.verifyCredentials()
    }
    
    @IBAction func settingsClicked(sender: UIBarButtonItem) {
        //Create the AlertController and add Its action like button in Actionsheet
        let actionSheet: UIAlertController = UIAlertController(title: "Settings", message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        actionSheet.addAction(cancelAction)
        
        let saveAction: UIAlertAction = UIAlertAction(title: "Edit API", style: .Default) { action -> Void in
            // TODO: Open API editor
        }
        actionSheet.addAction(saveAction)
        
        let deleteAction: UIAlertAction = UIAlertAction(title: "Settings", style: .Default) { action -> Void in
            // TODO: Open settings
        }
        actionSheet.addAction(deleteAction)
        presentViewController(actionSheet, animated: true, completion: nil)
    }
}
