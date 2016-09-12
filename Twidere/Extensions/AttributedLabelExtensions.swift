//
//  AttributedLabel+ALSBaselineSupport.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/8.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import AttributedLabel
import ALSLayouts

extension AttributedLabel: ALSBaselineSupport {
    
    public func calculateBaselineBottomValue() -> CGFloat {
        return font.ascender
    }
    
}