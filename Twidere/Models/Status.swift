// Automatically generated, DO NOT MODIFY
import Foundation

struct Status {

    // Fields
    var _id: Int64 
    var accountKey: UserKey 
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
    var quotedId: String? 
    var quotedCreatedAt: Date? 
    var quotedUserKey: UserKey? 
    var quotedUserName: String? 
    var quotedUserScreenName: String? 
    var quotedUserProfileImage: String? 
    var quotedTextPlain: String? 
    var quotedTextDisplay: String? 
    var quotedMetadata: Status.Metadata? 
    var retweetedByUserKey: UserKey? 
    var retweetedByUserName: String? 
    var retweetedByUserScreenName: String? 
    var retweetedByUserProfileImage: String? 
    var retweetId: String? 
    var retweetCreatedAt: Date? 
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
        var externalUrl: String 
        var replyCount: Int64 
        var retweetCount: Int64 
        var favoriteCount: Int64 
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
