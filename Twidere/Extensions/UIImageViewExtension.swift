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
        if let url = url {
            if completed != nil {
                self.sd_setImage(with: URL(string: url), placeholderImage: placeholder, options: [], completed: completed)
            } else {
                self.sd_setImage(with: URL(string: url), placeholderImage: placeholder)
            }
        } else {
            image = placeholder
        }
    }
    
    func makeCircular() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
