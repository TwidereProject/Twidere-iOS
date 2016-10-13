// Automatically generated, DO NOT MODIFY
import Foundation

struct MediaItem {

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
    // Append body content
 enum MediaType: String { case unknown, image, video, animatedGif, externalPlayer, variableType } 
    // Sub models
    struct VideoInfo {
    
        // Fields
        var variants: [Variant] 
        var duration: Int64 = -1 
        // Append body content
    
        // Sub models
            struct Variant {
            
                // Fields
                var url: String 
                var contentType: String 
                var bitrate: Int64 = -1 
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
