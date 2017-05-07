//
//  MediaPreviewContainer.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit
import TwidereCore

class MediaPreviewContainer: UIImageView {
    
    func displayMedia(_ media: [MediaItem]?) {
        contentMode = .scaleAspectFill
        if let item = media?.first {
            displayImage(item.previewUrl)
            layoutParams.hidden = false
        } else {
            displayImage(nil)
            layoutParams.hidden = true
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: size.width / 2)
    }
}
