// Automatically generated, DO NOT MODIFY
import Foundation

class Status {

    // Fields
    var _id: Int64 = -1
    var accountKey: UserKey!
    var sortId: Int64 = -1
    var positionKey: Int64 = -1
    var isGap: Bool = false
    var createdAt: Date
    var id: String
    var userKey: UserKey
    var userName: String
    var userScreenName: String
    var userProfileImage: String!
    var textPlain: String
    var textDisplay: String
    var metadata: Metadata? = nil
    var source: String? = nil
    var quotedId: String? = nil
    var quotedCreatedAt: Date? = nil
    var quotedUserKey: UserKey? = nil
    var quotedUserName: String? = nil
    var quotedUserScreenName: String? = nil
    var quotedUserProfileImage: String? = nil
    var quotedTextPlain: String? = nil
    var quotedTextDisplay: String? = nil
    var quotedMetadata: Metadata? = nil
    var quotedSource: String? = nil
    var retweetedByUserKey: UserKey? = nil
    var retweetedByUserName: String? = nil
    var retweetedByUserScreenName: String? = nil
    var retweetedByUserProfileImage: String? = nil
    var retweetId: String? = nil
    var retweetCreatedAt: Date? = nil
    // Initializers
    init(_id: Int64 = -1, accountKey: UserKey! = nil, sortId: Int64 = -1, positionKey: Int64 = -1, isGap: Bool = false, createdAt: Date, id: String, userKey: UserKey, userName: String, userScreenName: String, userProfileImage: String! = nil, textPlain: String, textDisplay: String, metadata: Metadata? = nil, source: String? = nil, quotedId: String? = nil, quotedCreatedAt: Date? = nil, quotedUserKey: UserKey? = nil, quotedUserName: String? = nil, quotedUserScreenName: String? = nil, quotedUserProfileImage: String? = nil, quotedTextPlain: String? = nil, quotedTextDisplay: String? = nil, quotedMetadata: Metadata? = nil, quotedSource: String? = nil, retweetedByUserKey: UserKey? = nil, retweetedByUserName: String? = nil, retweetedByUserScreenName: String? = nil, retweetedByUserProfileImage: String? = nil, retweetId: String? = nil, retweetCreatedAt: Date? = nil) {
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
        self.source = source
        self.quotedId = quotedId
        self.quotedCreatedAt = quotedCreatedAt
        self.quotedUserKey = quotedUserKey
        self.quotedUserName = quotedUserName
        self.quotedUserScreenName = quotedUserScreenName
        self.quotedUserProfileImage = quotedUserProfileImage
        self.quotedTextPlain = quotedTextPlain
        self.quotedTextDisplay = quotedTextDisplay
        self.quotedMetadata = quotedMetadata
        self.quotedSource = quotedSource
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
        var links: [LinkSpanItem]!
        var mentions: [MentionSpanItem]!
        var hashtags: [HashtagSpanItem]!
        var media: [MediaItem]!
        var displayRange: [Int]!
        var inReplyTo: InReplyTo!
        var externalUrl: String!
        var replyCount: Int64 = -1
        var retweetCount: Int64 = -1
        var favoriteCount: Int64 = -1
        // Initializers
        init(links: [LinkSpanItem]! = nil, mentions: [MentionSpanItem]! = nil, hashtags: [HashtagSpanItem]! = nil, media: [MediaItem]! = nil, displayRange: [Int]! = nil, inReplyTo: InReplyTo! = nil, externalUrl: String! = nil, replyCount: Int64 = -1, retweetCount: Int64 = -1, favoriteCount: Int64 = -1) {
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
                var userName: String!
                var userScreenName: String
                // Initializers
                init(statusId: String, userKey: UserKey, userName: String! = nil, userScreenName: String) {
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
