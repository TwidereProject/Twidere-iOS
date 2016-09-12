//
//  CoreLocationExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import CoreLocation

extension CLAuthorizationStatus {
    var hasAuthorization: Bool {
        get {
            return self == .AuthorizedAlways || self == .AuthorizedWhenInUse
        }
    }
    
}
