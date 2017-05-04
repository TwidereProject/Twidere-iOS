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


class ComposeController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate {

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
    @IBOutlet weak var attachmentCollectionView: UICollectionView!
    
    var locationAuthorizationGrantedSelector: Selector? = nil
    var keyboardHeight: CGFloat = 0
    
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
    var originalText: String? = nil
    
    var recentLocation: CLLocationCoordinate2D? = nil
    var attachedMedia: [MediaUpdate]? = nil
    var inReplyToStatus: Status? = nil
    
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
        
        attachmentCollectionView.dataSource = self
        attachmentCollectionView.delegate = self
        
        self.accountProfileImageView.layer.cornerRadius = self.accountProfileImageView.frame.size.width / 2
        self.accountProfileImageView.clipsToBounds = true
        
        let attachLocation = Defaults[.attachLocation]
        self.attachLocation = attachLocation
        if (attachLocation && CLLocationManager.authorizationStatus().hasAuthorization) {
            self.recentLocation = locationManager.location?.coordinate
        }
        
        if let originalText = originalText {
            editText.text = originalText
        } else if let inReplyToStatus = self.inReplyToStatus {
            var text = "@\(inReplyToStatus.userScreenName) "
            var range = NSMakeRange(text.utf16.count, 0)
            if let screenNames = inReplyToStatus.metadata?.mentions?.flatMap({ $0.screenName }) {
                for screenName in uniq(source: screenNames) {
                    if (inReplyToStatus.userScreenName != screenName) {
                        text += "@\(screenName) "
                    }
                }
            }
            range.length = text.utf16.count - range.location
            editText.text = text
            editText.selectedRange = range
        }
        
        updateMediaPreview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        editText.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidChangeFrame(_:)), name: .UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = DispatchQueue.global().promise { () -> Account in
            return try defaultAccount()!
        }.then { account -> Void in
                self.accountProfileImageView.displayImage(account.user.profileImageUrlForSize(.reasonablySmall), placeholder: UIImage(named: "Profile Image Default"))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidChangeFrame, object: nil)
        super.viewWillDisappear(animated)
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
        attachmentCollectionView.reloadData()
//        attachmedMediaCollectionView.fd_collapsed = attachedMedia?.isEmpty ?? true
    }

    func keyboardDidChangeFrame(_ notification: NSNotification) {
        let value: AnyObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject
        let keyboardFrame = self.view.convert(value.cgRectValue!, from: nil)
        self.keyboardHeight = keyboardFrame.height
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
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
        update.inReplyToStatus = self.inReplyToStatus
        bos.updateStatus(update)
        popupController?.dismiss()
    }
    
    @IBAction func attachLocationClicked(_ sender: UIBarButtonItem) {
        if (CLLocationManager.authorizationStatus().hasAuthorization) {
            showLocationViewController()
        } else {
            locationAuthorizationGrantedSelector = #selector(self.showLocationViewController)
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func attachMediaClicked(_ sender: UIBarButtonItem) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.showMediaPicker()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                if (status == .authorized) {
                    self.performSelector(onMainThread: #selector(self.showMediaPicker), with: nil, waitUntilDone: true)
                }
            }
        default:
            return
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        let accounts = try! allAccounts()
        let textLimit = accounts.flatMap { $0.extras?.characterLimit }.reduce(140) { (result, limit) -> Int in
            if (limit > 0 && limit < result) {
                return limit
            }
            return result
        }
        let textLength = Int(TwitterText.tweetLength(textView.text))
        sendTextCountView.text = "\(textLimit - textLength)"
    }
    
    @objc
    private func showMediaPicker() {
        let vc = UIImagePickerController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc, animated: true) {
            
        }
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if (viewControllerToPresent.transitioningDelegate === self) {
            NotificationCenter.default.removeObserver(self.popupController!, name: .UIKeyboardWillHide, object: nil)
        }
        
        super.present(viewControllerToPresent, animated: flag) {
            let pc = self.popupController!
            NotificationCenter.default.addObserver(pc, selector: Selector("keyboardWillHide:"), name: .UIKeyboardWillHide, object: nil)
            completion?()
        }
    }
    
    @objc
    private func showLocationViewController() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ComposeLocation") as! ComposeLocationController
        vc.callback = { location, precise in
            self.attachLocation = true
            self.recentLocation = location
        }
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        present(vc, animated: true) { 
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status.hasAuthorization && locationAuthorizationGrantedSelector != nil) {
            perform(locationAuthorizationGrantedSelector!, with: self)
        }
        locationAuthorizationGrantedSelector = nil
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = KeyboardHeightPresentationController(presentedViewController: presented, presenting: presenting)
        vc.height = keyboardHeight
        return vc
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func create() -> ComposeController {
        let storyboard = UIStoryboard(name: "Compose", bundle: nil)
        return storyboard.instantiateInitialViewController() as! ComposeController
    }
    
    static func create(inReplyTo: Status) -> ComposeController {
        let vc = create()
        vc.inReplyToStatus = inReplyTo
        return vc
    }
    
    func show(parent: UIViewController) {
        let controller = STPopupController(rootViewController: self)
        controller.containerView.layer.cornerRadius = 4
        controller.present(in: parent)
    }

}


class KeyboardHeightPresentationController : UIPresentationController {
    
    var height: CGFloat = 0
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let containerBounds = containerView!.bounds
        return CGRect(x: 0, y: containerBounds.height - self.height, width: containerBounds.width, height: self.height)
    }
}
