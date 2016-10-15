// Automatically generated, DO NOT MODIFY
import Foundation

class MediaItem {

    // Fields
    var url: String
    var mediaUrl: String?
    var previewUrl: String? = nil
    var type: MediaType = .unknown
    var width: Int = 0
    var height: Int = 0
    var videoInfo: VideoInfo
    var pageUrl: String? = nil
    var openBrowser: Bool = false
    var altText: String? = nil
    // Initializers
 init(url: String, mediaUrl: String?, previewUrl: String? = nil, type: MediaType = .unknown, width: Int = 0, height: Int = 0, videoInfo: VideoInfo, pageUrl: String? = nil, openBrowser: Bool = false, altText: String? = nil) {
self.url = url
self.mediaUrl = mediaUrl
self.previewUrl = previewUrl
self.type = type
self.width = width
self.height = height
self.videoInfo = videoInfo
self.pageUrl = pageUrl
self.openBrowser = openBrowser
self.altText = altText
}
    // Append body content
 enum MediaType: String { case unknown, image, video, animatedGif, externalPlayer, variableType } 
    // Sub models
    class VideoInfo {
    
        // Fields
        var variants: [Variant]
        var duration: Int64 = -1
        // Initializers
     init(variants: [Variant], duration: Int64 = -1) {
    self.variants = variants
    self.duration = duration
    }
        // Append body content
    
        // Sub models
            class Variant {
            
                // Fields
                var url: String
                var contentType: String? = nil
                var bitrate: Int64 = -1
                // Initializers
             init(url: String, contentType: String? = nil, bitrate: Int64 = -1) {
            self.url = url
            self.contentType = contentType
            self.bitrate = bitrate
            }
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
