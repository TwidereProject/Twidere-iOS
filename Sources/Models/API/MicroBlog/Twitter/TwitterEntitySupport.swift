//
//  TwitterEntitySupport.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

protocol TwitterEntitySupport {
    
    var entities: TwitterEntities? { get }
    
    var extendedEntities: TwitterEntities? { get }
}
