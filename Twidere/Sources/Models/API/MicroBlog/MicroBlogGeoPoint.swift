//
//  MicroBlogGeoPoint.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class MicroBlogGeoPoint {
    // sourcery: jsonField=coordinates
    var coordinates: [Double]!
    
    // sourcery: jsonField=type
    var type: String!
    
    var geoLocation: GeoLocation! {
        guard let coords = coordinates else {
            return nil
        }
        return GeoLocation(coords[0], coords[1])
    }
    
    required init() {
        
    }
}
