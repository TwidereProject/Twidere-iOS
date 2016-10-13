// Automatically generated, DO NOT MODIFY
import Foundation

struct Status {

    // Fields
    var _id: Int64 = -1 
    var accountKey: UserKey! 
    var sortId: Int64 
    var positionKey: Int64 
    var isGap: Bool 
    var createdAt: Date 
    var id: String 
    var userKey: UserKey 
    var userName: String 
    var userScreenName: String 
    var userProfileImage: String 
    var textPlain: String 
    var textDisplay: String 
    var metadata: Status.Metadata? 
    var quotedId: String? = nil 
    var quotedCreatedAt: Date? = nil 
    var quotedUserKey: UserKey? = nil 
    var quotedUserName: String? = nil 
    var quotedUserScreenName: String? = nil 
    var quotedUserProfileImage: String? = nil 
    var quotedTextPlain: String? = nil 
    var quotedTextDisplay: String? = nil 
    var quotedMetadata: Status.Metadata? = nil 
    var retweetedByUserKey: UserKey? = nil 
    var retweetedByUserName: String? = nil 
    var retweetedByUserScreenName: String? = nil 
    var retweetedByUserProfileImage: String? = nil 
    var retweetId: String? = nil 
    var retweetCreatedAt: Date? = nil 
    // Append body content

    // Sub models
    struct Metadata {
    
        // Fields
        var links: [LinkSpanItem]? 
        var mentions: [MentionSpanItem]? 
        var hashtags: [HashtagSpanItem]? 
        var media: [MediaItem]? 
        var displayRange: [Int]? 
        var inReplyTo: Status.Metadata.InReplyTo? 
        var externalUrl: String? 
        var replyCount: Int64? 
        var retweetCount: Int64? 
        var favoriteCount: Int64? 
        // Append body content
    
        // Sub models
            struct InReplyTo {
            
                // Fields
                var statusId: String 
                var userKey: UserKey 
                var userName: String? 
                var userScreenName: String 
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
