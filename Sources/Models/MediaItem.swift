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

    // Sub models
    
    enum MediaType : String {
    
        // Fields
        case unknown
        case image
        case video
        case animatedGif
        case externalPlayer
        case variableType
    
        var rawValue: String {
            switch self {
            case .unknown: return "unknown"
            case .image: return "image"
            case .video: return "video"
            case .animatedGif: return "animated_gif"
            case .externalPlayer: return "external_player"
            case .variableType: return "variable_type"
            }
        }
    
        init?(rawValue: String) {
            switch rawValue {
            case "unknown": self = .unknown
            case "image": self = .image
            case "video": self = .video
            case "animated_gif": self = .animatedGif
            case "external_player": self = .externalPlayer
            case "variable_type": self = .variableType
            default: return nil
            }
        }
            
        // Append body content
    
    
    }
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
