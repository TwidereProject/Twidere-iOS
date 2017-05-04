// sourcery: jsonParse
public class Entities {
    
    // sourcery: jsonField=urls
    public var urls: [UrlEntity]!
    
    // sourcery: jsonField=hashtags
    public var hashtags: [HashtagEntity]!
    
    // sourcery: jsonField=mentions
    public var mentions: [UserMentionEntity]!
    
    required public init() {
        
    }
}
