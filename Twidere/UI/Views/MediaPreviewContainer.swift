//
//  MediaPreviewContainer.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import UIKit

class MediaPreviewContainer: UIImageView {
    
    func displayMedia(media: [MediaItem]?) {
        contentMode = .ScaleAspectFill
        if let item = media?.first {
            displayImage(item.previewUrl)
            layoutParams.hidden = false
        } else {
            displayImage(nil)
            layoutParams.hidden = true
        }
    }
    
    override func sizeThatFits(size: CGSize) -> CGSize {
        return CGSizeMake(size.width, size.width / 2)
    }
}