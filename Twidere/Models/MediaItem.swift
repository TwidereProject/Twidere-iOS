// Automatically generated, DO NOT MODIFY
import Foundation

class MediaItem {

    // Fields
    var url: String!
    var mediaUrl: String?
    var previewUrl: String? = nil
    var type: MediaType = .Unknown
    var width: Int = 0
    var height: Int = 0
    var videoInfo: VideoInfo!
    var pageUrl: String? = nil
    var openBrowser: Bool = false
    var altText: String? = nil
    // Append body content
 enum MediaType: String { case Unknown, Image, Video, AnimatedGif, ExternalPlayer, VariableType } 
    // Sub models
    class VideoInfo {
    
        // Fields
        var variants: [Variant]!
        var duration: Int64 = -1
        // Append body content
    
        // Sub models
            class Variant {
            
                // Fields
                var url: String!
                var contentType: String!
                var bitrate: Int64 = -1
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
