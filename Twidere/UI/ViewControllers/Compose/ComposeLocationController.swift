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
    
    var callback: ((_ location: CLLocationCoordinate2D, _ precise: Bool) -> Void)? = nil
    
    override func viewDidLoad() {
        mapView.delegate = self
        preciseLocationSwitch.isOn = Defaults[.attachPreciseLocation] 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Defaults[.attachPreciseLocation] = preciseLocationSwitch.isOn
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        preciseLocationLabel.text = String(format: "%.2f,%.2f", userLocation.coordinate.latitude, userLocation.coordinate.longitude)
    }
    
    @IBAction func doneAttachLocation(_ sender: UIBarButtonItem) {
        callback?(mapView.userLocation.coordinate, preciseLocationSwitch.isOn)
        popupController.popViewController(animated: true)
    }
}
