//
//  MediaItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

class MediaItem {
    
    var url: String!
    var mediaUrl: String? = nil
    var previewUrl: String? = nil
    var type: MediaType = .Unknown
    var width: Int = 0
    var height: Int = 0
    var videoInfo: VideoInfo!
    var pageUrl: String? = nil
    var openBrowser: Bool = false
    var altText: String? = nil
    
    init() {
        
    }
    
    enum MediaType: String {
        case Unknown, Image, Video, AnimatedGif, ExternalPlayer, VariableType
    }
    
    class VideoInfo {
        
        var variants: [Variant]!
        var duration: Int64 = -1
        
        init() {
            
        }
        
        class Variant {
            
            var url: String!
            var contentType: String!
            var bitrate: Int64 = -1
            
            init() {
                
            }

        }
    }
}