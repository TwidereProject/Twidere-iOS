
// sourcery: jsonParse
public class MediaItem {
    
    // sourcery:jsonField=url
    public var url: String!
    // sourcery:jsonField=media_url
    public var mediaUrl: String?
    // sourcery:jsonField=preview_url
    public var previewUrl: String? = nil
    // sourcery:jsonField=type
    // sourcery:jsonFieldConverter=MediaItemTypeFieldConverter
    public var type: MediaType = .unknown
    // sourcery:jsonField=width
    public var width: Int = 0
    // sourcery:jsonField=height
    public var height: Int = 0
    // sourcery:jsonField=video_info
    public var videoInfo: VideoInfo? = nil
    // sourcery:jsonField=page_url
    public var pageUrl: String? = nil
    // sourcery:jsonField=open_browser
    public var openBrowser: Bool = false
    // sourcery:jsonField=alt_text
    public var altText: String? = nil
    
    required public init() {
        
    }
    
    public enum MediaType : String {
        
        // Fields
        case unknown
        case image
        case video
        case animatedGif
        case externalPlayer
        case variableType
        
        public var rawValue: String {
            switch self {
            case .unknown: return "unknown"
            case .image: return "image"
            case .video: return "video"
            case .animatedGif: return "animated_gif"
            case .externalPlayer: return "external_player"
            case .variableType: return "variable_type"
            }
        }
        
        public init?(rawValue: String) {
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
    public class VideoInfo {
        
        // Fields
        public var variants: [Variant]!
        public var duration: Int64 = -1
        
        required public init() {
            
        }
        
        // sourcery: jsonParse
        public class Variant {
            
            // Fields
            public var url: String!
            public var contentType: String? = nil
            public var bitrate: Int64 = -1
            
            required public init() {
                
            }
        }
    }
}
