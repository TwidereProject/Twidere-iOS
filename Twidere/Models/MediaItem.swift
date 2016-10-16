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
    // Initializers

    // Append body content

    // Sub models
    enum MediaType : String {
    
        // Fields
        case unknown
        case image
        case video
        case animatedGif
        case externalPlayer
        case variableType
        // Append body content
    
    
    }
    struct VideoInfo {
    
        // Fields
        var variants: [Variant]
        var duration: Int64 = -1
        // Initializers
    
        // Append body content
    
        // Sub models
            struct Variant {
            
                // Fields
                var url: String
                var contentType: String? = nil
                var bitrate: Int64 = -1
                // Initializers
            
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
