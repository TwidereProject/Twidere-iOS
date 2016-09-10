//
//  MediaItem.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/10.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Gloss

class MediaItem: Glossy {
    
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
    
    required init?(json: JSON) {
        self.url = "url" <~~ json
        self.mediaUrl = "media_url" <~~ json
        self.previewUrl = "preview_url" <~~ json
        if let type: String = "type" <~~ json {
            self.type = MediaType(rawValue: type) ?? .Unknown
        } else {
            self.type = .Unknown
        }
        self.width = "width" <~~ json ?? 0
        self.height = "height" <~~ json ?? 0
        self.videoInfo = "video_info" <~~ json
        self.pageUrl = "page_url" <~~ json
        self.openBrowser = "open_browser" <~~ json ?? false
        self.altText = "alt_text" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "url" ~~> self.url,
            "media_url" ~~> self.mediaUrl,
            "preview_url" ~~> self.previewUrl,
            "type" ~~> self.type.rawValue,
            "width" ~~> self.width,
            "height" ~~> self.height,
            "video_info" ~~> self.videoInfo,
            "page_url" ~~> self.pageUrl,
            "open_browser" ~~> self.openBrowser,
            "alt_text" ~~> self.altText
        ])
    }
    
    enum MediaType: String {
        case Unknown, Image, Video, AnimatedGif, ExternalPlayer, VariableType
    }
    
    class VideoInfo: Glossy {
        
        var variants: [Variant]!
        var duration: Int64 = -1
        
        init() {
            
        }
        
        required init?(json: JSON) {
            self.variants = "variants" <~~ json
            self.duration = "duration" <~~ json ?? -1
        }
        
        func toJSON() -> JSON? {
            return jsonify([
                "variants" ~~> self.variants,
                "duration" ~~> self.duration
                ])
        }
        
        class Variant: Glossy {
            
            var url: String!
            var contentType: String!
            var bitrate: Int64 = -1
            
            init() {
                
            }
            
            required init?(json: JSON) {
                self.url = "url" <~~ json
                self.contentType = "content_type" <~~ json
                self.bitrate = "bitrate" <~~ json ?? -1
            }
            
            func toJSON() -> JSON? {
                return jsonify([
                    "url" ~~> self.url,
                    "content_type" ~~> self.contentType,
                    "bitrate" ~~> self.bitrate
                    ])
            }
        }
    }
}