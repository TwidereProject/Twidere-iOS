//
//  YYTextExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/7.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import ALSLayouts
import YYText

extension YYLabel: ALSBaselineSupport {
    
    public func calculateBaselineBottomValue() -> CGFloat {
        return font.ascender
    }
    
}
