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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
        
        sendItem.customView?.touchHighlightingStyle = .transparentMask
        
        sendIconView.tintColor = sendItem.tintColor
        let tintedImage = sendIconView.image!.withRenderingMode(.alwaysTemplate)
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return attachedMedia?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaItem", for: indexPath)
        guard let media = attachedMedia?[(indexPath as NSIndexPath).item] else {
            return cell
        }
        let previewImageView = cell.viewWithTag(101) as! UIImageView
        previewImageView.image = UIImage(contentsOfFile: media.path)
        return cell
    }
    
    
    func addMedia(_ media: MediaUpdate) {
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

    @IBAction func updateStatusTapped(_ sender: UITapGestureRecognizer) {
        guard let text = self.editText.text else {
            //
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    
    @IBAction func attachLocationClicked(_ sender: UIBarButtonItem) {
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
    
    @IBAction func attachMediaClicked(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
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
    
    func textViewDidChange(_ textView: UITextView) {
        let accounts = try! allAccounts()
        let textLimit = accounts.map { $0.config?.characterLimit }.reduce(140) { (result, limit) -> Int in
            if (limit > 0 && limit < result) {
                return limit!
            }
            return result
        }
        let textLength = Int(TwitterText.tweetLength(textView.text))
        sendTextCountView.text = "\(textLimit - textLength)"
    }
    
    
    func showLocationViewController() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ComposeLocation") as! ComposeLocationController
        vc.callback = { location, precise in
            self.attachLocation = true
            self.recentLocation = location
        }
        popupController.push(vc, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status.hasAuthorization && locationAuthorizationGrantedSelector != nil) {
            perform(locationAuthorizationGrantedSelector!, with: self)
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
    
    static func show(_ parent: UIViewController, identifier: String) {
        let root = parent.storyboard?.instantiateViewController(withIdentifier: identifier)
        let controller = STPopupController(rootViewController: root)
        controller?.containerView.layer.cornerRadius = 4;

        controller?.present(in: parent)
    }

}
