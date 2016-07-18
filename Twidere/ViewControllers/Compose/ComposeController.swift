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
import UITextView_Placeholder
import twitter_text
import UIView_TouchHighlighting
import CoreLocation
import SwiftyUserDefaults

class ComposeController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate {

    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    @IBOutlet weak var editText: UITextView!
    @IBOutlet weak var locationItem: UIBarButtonItem!
    @IBOutlet weak var sendItem: UIBarButtonItem!
    @IBOutlet weak var sendTextCountView: UILabel!
    @IBOutlet weak var sendIconView: UIImageView!
    @IBOutlet weak var accountProfileImageView: UIImageView!
    
    var locationAuthorizationGrantedSelector: Selector? = nil
    
    var attachLocation: Bool {
        get {
            return Defaults[.attachLocation]
        }
        set {
            Defaults[.attachLocation] = newValue
            if (newValue) {
                locationItem.image = UIImage(named: "Toolbar Location")
            } else {
                locationItem.image = UIImage(named: "Toolbar Location Outline")
            }
        }
    }
    
    var currentLocation: CLLocationCoordinate2D? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.title = "Compose"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        // Do any additional setup after loading the view.
        
        sendItem.customView?.touchHighlightingStyle = .TransparentMask
        
        sendIconView.tintColor = sendItem.tintColor
        let tintedImage = sendIconView.image!.imageWithRenderingMode(.AlwaysTemplate)
        sendIconView.image = tintedImage
        
        editText.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        editText.delegate = self
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func updateStatusTapped(sender: UITapGestureRecognizer) {
        guard let text = self.editText.text else {
            //
            return
        }
        
        dispatch_promise { () -> JSON in
            let db = (UIApplication.sharedApplication().delegate as! AppDelegate).coreDataStorage
            let account = try db.fetch(Request<Account>()).first!
            let config = account.createAPIConfig()
            let auth = account.createAuthorization()
            let microBlog = MicroBlogService(endpoint: config.createEndpoint("api"), auth: auth)
            return try microBlog.updateStatus(text)
        }.error { error in
            debugPrint(error)
        }
    }
    
    @IBAction func attachLocationClicked(sender: UIBarButtonItem) {
        if (self.attachLocation) {
            // Remove location
            self.attachLocation = false
        } else if (CLLocationManager.authorizationStatus().hasAuthorization) {
            showLocationViewController()
        } else {
            locationAuthorizationGrantedSelector = #selector(self.showLocationViewController)
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        let textLength = TwitterText.tweetLength(textView.text)
        sendTextCountView.text = "\(textLength)"
    }
    
    
    func showLocationViewController() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ComposeLocation") as! ComposeLocationController
        vc.callback = { location in
            self.attachLocation = true
            self.currentLocation = location
        }
        popupController.pushViewController(vc, animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status.hasAuthorization && locationAuthorizationGrantedSelector != nil) {
            performSelector(locationAuthorizationGrantedSelector!, withObject: self)
        }
        locationAuthorizationGrantedSelector = nil
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
