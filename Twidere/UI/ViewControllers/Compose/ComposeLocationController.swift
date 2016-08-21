//
//  ComposeLocationController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import STPopup
import MapKit
import SwiftyUserDefaults

class ComposeLocationController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var preciseLocationSwitch: UISwitch!
    @IBOutlet weak var preciseLocationLabel: UILabel!
    
    var callback: ((location: CLLocationCoordinate2D, precise: Bool) -> Void)? = nil
    
    override func viewDidLoad() {
        mapView.delegate = self
        preciseLocationSwitch.on = Defaults[.attachPreciseLocation] ?? false
    }
    
    override func viewWillDisappear(animated: Bool) {
        Defaults[.attachPreciseLocation] = preciseLocationSwitch.on
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        preciseLocationLabel.text = String(format: "%.2f,%.2f",userLocation.coordinate.latitude, userLocation.coordinate.longitude)
    }
    
    @IBAction func doneAttachLocation(sender: UIBarButtonItem) {
        callback?(location: mapView.userLocation.coordinate, precise: preciseLocationSwitch.on)
        popupController.popViewControllerAnimated(true)
    }
}