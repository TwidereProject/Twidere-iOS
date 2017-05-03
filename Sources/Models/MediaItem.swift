
// sourcery: jsonParse
class MediaItem {
    
    // sourcery:jsonFieldName=url
    var url: String!
    // sourcery:jsonFieldName=media_url
    var mediaUrl: String?
    // sourcery:jsonFieldName=preview_url
    var previewUrl: String? = nil
    // sourcery:jsonFieldName=type
    // sourcery:jsonFieldConverter=MediaItemTypeFieldConverter
    var type: MediaType = .unknown
    // sourcery:jsonFieldName=width
    var width: Int = 0
    // sourcery:jsonFieldName=height
    var height: Int = 0
    // sourcery:jsonFieldName=video_info
    var videoInfo: VideoInfo? = nil
    // sourcery:jsonFieldName=page_url
    var pageUrl: String? = nil
    // sourcery:jsonFieldName=open_browser
    var openBrowser: Bool = false
    // sourcery:jsonFieldName=alt_text
    var altText: String? = nil
    
    required init() {
        
    }
    
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
        
        
        
    }
    
    // sourcery: jsonParse
    class VideoInfo {
        
        // Fields
        var variants: [Variant]!
        var duration: Int64 = -1
        
        required init() {
            
        }
        
        // sourcery: jsonParse
        class Variant {
            
            // Fields
            var url: String!
            var contentType: String? = nil
            var bitrate: Int64 = -1
            
            required init() {
                
            }
        }
    }
}
