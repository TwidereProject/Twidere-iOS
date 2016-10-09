//
//  MediaViewerController.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import MWPhotoBrowser

class MediaViewerController: MWPhotoBrowser {
    
    private(set) var media: [MediaItem]!
    
    init(media: [MediaItem]) {
        self.media = media
        super.init(photos: media.map{ $0.mwPhoto })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
}
