//
//  MediaItem+MWPhoto.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import MWPhotoBrowser

extension MediaItem {
    var mwPhoto: MWPhoto {
        switch self.type {
        case .image:
            let photo = MWPhoto(url: URL(string: self.mediaUrl!)!)!
            return photo
        case .video:
            let photo = MWPhoto(url: URL(string: self.mediaUrl!)!)!
            photo.isVideo = true
            photo.videoURL = URL(string: self.videoInfo.variants.first!.url)
            return photo
        default:
            let photo = MWPhoto(url: URL(string: self.mediaUrl!)!)!
            return photo
        }
    }
}
