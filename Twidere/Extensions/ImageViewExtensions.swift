//
//  ImageViewExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/16.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func displayImage(_ url: String?, placeholder: UIImage? = nil, completed: SDWebImageCompletionBlock? = nil) {
        if (url != nil) {
            sd_setImage(with: URL(string: url!), placeholderImage: placeholder, completed: completed)
        } else {
            image = placeholder
        }
    }
}
