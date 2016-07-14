//
//  ComposeController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import STPopup
import SugarRecord
import PromiseKit
import SwiftyJSON

class ComposeController: UIViewController {

    lazy var db: CoreDataDefaultStorage = {
        return AppDelegate.coreDataStorage()
    }()
    
    @IBOutlet weak var editText: UITextView!
    @IBOutlet weak var sendItem: UIBarButtonItem!
    @IBOutlet weak var sendTextCountView: UILabel!
    @IBOutlet weak var sendIconView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = "Compose"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sendIconView.tintColor = sendItem.tintColor
        let tintedImage = sendIconView.image!.imageWithRenderingMode(.AlwaysTemplate)
        sendIconView.image = tintedImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func updateStatusClicked(sender: UIBarButtonItem) {
        
        guard let text = self.editText.text else {
            //
            return
        }
        
        dispatch_promise { () -> JSON in
            let account = try self.db.fetch(Request<Account>()).first!
            let config = CustomAPIConfig()
            config.apiUrlFormat = account.apiUrlFormat!
            config.authType = CustomAPIConfig.AuthType(rawValue: account.authType!)!
            config.consumerKey = account.consumerKey!
            config.consumerSecret = account.consumerSecret!
            config.sameOAuthSigningUrl = Bool(account.sameOAuthSigningUrl!)
            config.noVersionSuffix = Bool(account.noVersionSuffix!)
            
            let token = OAuthToken(account.oauthToken!, account.oauthTokenSecret!)
            let auth = OAuthAuthorization(config.consumerKey, config.consumerSecret, oauthToken: token)
            let microBlog = MicroBlogService(endpoint: config.createEndpoint("api"), auth: auth)
            return try microBlog.updateStatus(text)
        }.error { error in
            debugPrint(error)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func show(parent: UIViewController, identifier: String) {
        let root = parent.storyboard?.instantiateViewControllerWithIdentifier(identifier)
        let controller = STPopupController(rootViewController: root)
        controller.containerView.layer.cornerRadius = 4;

        controller.presentInViewController(parent)
    }

}
