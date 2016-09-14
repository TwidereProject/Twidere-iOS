//
//  ViewSizeUtils.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import ALSLayouts

extension UITableViewCell {
    func sizeThatFitsALS(_ size: CGSize) -> CGSize {
        let layout = contentView.subviews.first as! ALSBaseLayout
        var layoutSize = size
        layoutSize.width -= contentView.layoutMargins.left + contentView.layoutMargins.right
        layoutSize.height -= contentView.layoutMargins.top + contentView.layoutMargins.bottom
        var contentSize = layout.sizeThatFits(layoutSize)
        contentSize.width += contentView.layoutMargins.left + contentView.layoutMargins.right
        contentSize.height += contentView.layoutMargins.top + contentView.layoutMargins.bottom
        return contentSize
    }
}
