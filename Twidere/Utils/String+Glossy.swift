//
//  String+Glossy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Gloss

extension String {
    
    func decodeJSON<T : Glossy>() -> T? {
        guard let json = try! NSJSONSerialization.JSONObjectWithData(self.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions(rawValue: 0)) as? JSON else {
            return nil
        }
        return T(json: json)
    }
    
}

extension Glossy {
    
    func encodeJSON() -> String {
        return String(data: try! NSJSONSerialization.dataWithJSONObject(self.toJSON()!, options: NSJSONWritingOptions(rawValue: 0)), encoding: NSUTF8StringEncoding)!
    }
    
}