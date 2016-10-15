// Automatically generated, DO NOT MODIFY
import Foundation

class Status {

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
    var metadata: Metadata?
    var quotedId: String?
    var quotedCreatedAt: Date
    var quotedUserKey: UserKey?
    var quotedUserName: String?
    var quotedUserScreenName: String?
    var quotedUserProfileImage: String?
    var quotedTextPlain: String?
    var quotedTextDisplay: String?
    var quotedMetadata: Metadata?
    var retweetedByUserKey: UserKey?
    var retweetedByUserName: String?
    var retweetedByUserScreenName: String?
    var retweetedByUserProfileImage: String?
    var retweetId: String?
    var retweetCreatedAt: Date
    // Initializers
 init(_id: Int64 = -1, accountKey: UserKey!, sortId: Int64, positionKey: Int64, isGap: Bool, createdAt: Date, id: String, userKey: UserKey, userName: String, userScreenName: String, userProfileImage: String, textPlain: String, textDisplay: String, metadata: Metadata?, quotedId: String?, quotedCreatedAt: Date, quotedUserKey: UserKey?, quotedUserName: String?, quotedUserScreenName: String?, quotedUserProfileImage: String?, quotedTextPlain: String?, quotedTextDisplay: String?, quotedMetadata: Metadata?, retweetedByUserKey: UserKey?, retweetedByUserName: String?, retweetedByUserScreenName: String?, retweetedByUserProfileImage: String?, retweetId: String?, retweetCreatedAt: Date) {
self._id = _id
self.accountKey = accountKey
self.sortId = sortId
self.positionKey = positionKey
self.isGap = isGap
self.createdAt = createdAt
self.id = id
self.userKey = userKey
self.userName = userName
self.userScreenName = userScreenName
self.userProfileImage = userProfileImage
self.textPlain = textPlain
self.textDisplay = textDisplay
self.metadata = metadata
self.quotedId = quotedId
self.quotedCreatedAt = quotedCreatedAt
self.quotedUserKey = quotedUserKey
self.quotedUserName = quotedUserName
self.quotedUserScreenName = quotedUserScreenName
self.quotedUserProfileImage = quotedUserProfileImage
self.quotedTextPlain = quotedTextPlain
self.quotedTextDisplay = quotedTextDisplay
self.quotedMetadata = quotedMetadata
self.retweetedByUserKey = retweetedByUserKey
self.retweetedByUserName = retweetedByUserName
self.retweetedByUserScreenName = retweetedByUserScreenName
self.retweetedByUserProfileImage = retweetedByUserProfileImage
self.retweetId = retweetId
self.retweetCreatedAt = retweetCreatedAt
}
    // Append body content

    // Sub models
    class Metadata {
    
        // Fields
        var links: [LinkSpanItem]?
        var mentions: [MentionSpanItem]?
        var hashtags: [HashtagSpanItem]?
        var media: [MediaItem]?
        var displayRange: [Int]?
        var inReplyTo: InReplyTo?
        var externalUrl: String
        var replyCount: Int64
        var retweetCount: Int64
        var favoriteCount: Int64
        // Initializers
     init(links: [LinkSpanItem]?, mentions: [MentionSpanItem]?, hashtags: [HashtagSpanItem]?, media: [MediaItem]?, displayRange: [Int]?, inReplyTo: InReplyTo?, externalUrl: String, replyCount: Int64, retweetCount: Int64, favoriteCount: Int64) {
    self.links = links
    self.mentions = mentions
    self.hashtags = hashtags
    self.media = media
    self.displayRange = displayRange
    self.inReplyTo = inReplyTo
    self.externalUrl = externalUrl
    self.replyCount = replyCount
    self.retweetCount = retweetCount
    self.favoriteCount = favoriteCount
    }
        // Append body content
    
        // Sub models
            class InReplyTo {
            
                // Fields
                var statusId: String
                var userKey: UserKey
                var userName: String?
                var userScreenName: String
                // Initializers
             init(statusId: String, userKey: UserKey, userName: String?, userScreenName: String) {
            self.statusId = statusId
            self.userKey = userKey
            self.userName = userName
            self.userScreenName = userScreenName
            }
                // Append body content
            
                // Sub models
            
            
            }
    
    }

}
