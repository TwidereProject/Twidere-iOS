// sourcery: jsonParse
class Entities {
    
    // sourcery: jsonField=urls
    var urls: [UrlEntity]!
    
    // sourcery: jsonField=hashtags
    var hashtags: [HashtagEntity]!
    
    // sourcery: jsonField=mentions
    var mentions: [UserMentionEntity]!
    
    required init() {
        
    }
}
