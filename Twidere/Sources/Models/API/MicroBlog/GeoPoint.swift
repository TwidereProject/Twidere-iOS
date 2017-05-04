//
//  MicroBlogGeoPoint.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class GeoPoint {
    // sourcery: jsonField=coordinates
    var coordinates: [Double]!
    
    // sourcery: jsonField=type
    var type: String!
    
    var geoLocation: GeoLocation! {
        guard let coords = coordinates, coords.count == 2 else {
            return nil
        }
        return GeoLocation(latitude: coords[0], longitude: coords[1])
    }
    
    required init() {
        
    }
}
