//
//  ComposeController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import STPopup
import PromiseKit
import SwiftyJSON
import UITextView_Placeholder
import twitter_text
import UIView_TouchHighlighting
import CoreLocation
import SwiftyUserDefaults
import AssetsLibrary
import Photos
import UIView_FDCollapsibleConstraints

class ComposeController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var locationManager: CLLocationManager = {
        return CLLocationManager()
    }()
    
    lazy var imageManager: PHImageManager = {
        return PHImageManager()
    }()
    
    @IBOutlet weak var editText: UITextView!
    @IBOutlet weak var locationItem: UIBarButtonItem!
    @IBOutlet weak var sendItem: UIBarButtonItem!
    @IBOutlet weak var sendTextCountView: UILabel!
    @IBOutlet weak var sendIconView: UIImageView!
    @IBOutlet weak var accountProfileImageView: UIImageView!
    @IBOutlet weak var attachmedMediaCollectionView: UICollectionView!
    
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
    
    var recentLocation: CLLocationCoordinate2D? = nil
    var attachedMedia: [MediaUpdate]? = nil
    
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
        
        attachmedMediaCollectionView.dataSource = self
        attachmedMediaCollectionView.delegate = self
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
        let attachLocation = Defaults[.attachLocation]
        self.attachLocation = attachLocation
        if (attachLocation && CLLocationManager.authorizationStatus().hasAuthorization) {
            self.recentLocation = locationManager.location?.coordinate
        }
        
        updateMediaPreview()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachedMedia?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MediaItem", forIndexPath: indexPath)
        guard let media = attachedMedia?[indexPath.item] else {
            return cell
        }
        let previewImageView = cell.viewWithTag(101) as! UIImageView
        previewImageView.image = UIImage(contentsOfFile: media.path)
        return cell
    }
    
    
    func addMedia(media: MediaUpdate) {
        if (self.attachedMedia == nil) {
            self.attachedMedia = []
        }
        self.attachedMedia!.append(media)
        updateMediaPreview()
    }
    
    func updateMediaPreview() {
        attachmedMediaCollectionView.reloadData()
        attachmedMediaCollectionView.fd_collapsed = attachedMedia?.isEmpty ?? true
    }

    @IBAction func updateStatusTapped(sender: UITapGestureRecognizer) {
        guard let text = self.editText.text else {
            //
            return
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let bos = appDelegate.backgroundOperationService
        let accounts = try! allAccounts()
        let update = StatusUpdate(accounts: accounts, text: text)
        if (attachLocation && recentLocation != nil) {
            update.location = (recentLocation!.latitude, recentLocation!.longitude)
            update.displayCoordinates = Defaults[.attachPreciseLocation]
        }
        update.media = self.attachedMedia
        bos.updateStatus(update)
        popupController.dismiss()
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
    
    @IBAction func attachMediaClicked(sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        firstly { () -> Promise<[String: AnyObject]> in
            return promiseViewController(picker, animated: true, completion: nil)
        }.then { (info) -> Promise<NSData> in
            return Promise { fullfill, reject in
                let imageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
                
                let asset = PHAsset.fetchAssetsWithALAssetURLs([imageUrl], options: nil).firstObject as! PHAsset
                self.imageManager.requestImageDataForAsset(asset, options: nil, resultHandler: { (data, dataUTI, orientation, info) in
                    if (data != nil) {
                        fullfill(data!)
                    }
                })
            }
        }.thenInBackground { data -> MediaUpdate? in
            guard let path = NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true).first else {
                return nil
            }
            
            let timestamp = NSDate().timeIntervalSince1970
            var writePath = NSURL(fileURLWithPath: path).URLByAppendingPathComponent("\(timestamp)").path!
            let fm = NSFileManager.defaultManager()
            var n = 0
            while (fm.fileExistsAtPath(writePath)) {
                writePath = NSURL(fileURLWithPath: path).URLByAppendingPathComponent("\(timestamp)_\(n)").path!
                n += 1
            }
            fm.createFileAtPath(writePath, contents: data, attributes: nil)
            let media = MediaUpdate(path: writePath, type: .Image)
            return media
        }.then { media -> Void in
            if (media != nil) {
                self.addMedia(media!)
            }
        }
        
    }
    
    func textViewDidChange(textView: UITextView) {
        let textLength = TwitterText.tweetLength(textView.text)
        sendTextCountView.text = "\(textLength)"
    }
    
    
    func showLocationViewController() {
        let vc = storyboard?.instantiateViewControllerWithIdentifier("ComposeLocation") as! ComposeLocationController
        vc.callback = { location, precise in
            self.attachLocation = true
            self.recentLocation = location
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
