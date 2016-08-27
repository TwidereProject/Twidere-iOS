//
//  Metadata+JSON.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension FlatStatus.Metadata {
    
    static func parse(fromJson: JSON) -> FlatStatus.Metadata {
        let metadata = FlatStatus.Metadata()
        return metadata
    }

    var json: JSON {
        let json = JSON(self)
        return json
    }
    
    
}