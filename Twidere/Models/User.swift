// Automatically generated, DO NOT MODIFY
import Foundation

class User {

    // Fields
    var _id: Int64 = -1
    var accountKey: UserKey!
    var key: UserKey
    var createdAt: Date!
    var position: Int64 = -1
    var isProtected: Bool = false
    var isVerified: Bool = false
    var name: String
    var screenName: String
    var profileImageUrl: String!
    var profileBannerUrl: String!
    var profileBackgroundUrl: String!
    var descriptionPlain: String!
    var descriptionDisplay: String!
    var url: String!
    var urlExpanded: String!
    var location: String!
    var metadata: Metadata? = nil
    // Initializers
    init(_id: Int64 = -1, accountKey: UserKey! = nil, key: UserKey, createdAt: Date! = nil, position: Int64 = -1, isProtected: Bool = false, isVerified: Bool = false, name: String, screenName: String, profileImageUrl: String! = nil, profileBannerUrl: String! = nil, profileBackgroundUrl: String! = nil, descriptionPlain: String! = nil, descriptionDisplay: String! = nil, url: String! = nil, urlExpanded: String! = nil, location: String! = nil, metadata: Metadata? = nil) {
        self._id = _id
        self.accountKey = accountKey
        self.key = key
        self.createdAt = createdAt
        self.position = position
        self.isProtected = isProtected
        self.isVerified = isVerified
        self.name = name
        self.screenName = screenName
        self.profileImageUrl = profileImageUrl
        self.profileBannerUrl = profileBannerUrl
        self.profileBackgroundUrl = profileBackgroundUrl
        self.descriptionPlain = descriptionPlain
        self.descriptionDisplay = descriptionDisplay
        self.url = url
        self.urlExpanded = urlExpanded
        self.location = location
        self.metadata = metadata
    }
    // Append body content

    // Sub models
    class Metadata {
    
        // Fields
        var following: Bool
        var followedBy: Bool
        var blocking: Bool
        var blockedBy: Bool
        var muting: Bool
        var followRequestSent: Bool
        var descriptionLinks: [LinkSpanItem]?
        var descriptionMentions: [MentionSpanItem]?
        var descriptionHashtags: [HashtagSpanItem]?
        var linkColor: String? = nil
        var backgroundColor: String? = nil
        var statusesCount: Int64
        var followersCount: Int64
        var friendsCount: Int64
        var favoritesCount: Int64
        var mediaCount: Int64
        var listsCount: Int64
        var listedCount: Int64
        var groupsCount: Int64
        // Initializers
        init(following: Bool, followedBy: Bool, blocking: Bool, blockedBy: Bool, muting: Bool, followRequestSent: Bool, descriptionLinks: [LinkSpanItem]?, descriptionMentions: [MentionSpanItem]?, descriptionHashtags: [HashtagSpanItem]?, linkColor: String? = nil, backgroundColor: String? = nil, statusesCount: Int64, followersCount: Int64, friendsCount: Int64, favoritesCount: Int64, mediaCount: Int64, listsCount: Int64, listedCount: Int64, groupsCount: Int64) {
            self.following = following
            self.followedBy = followedBy
            self.blocking = blocking
            self.blockedBy = blockedBy
            self.muting = muting
            self.followRequestSent = followRequestSent
            self.descriptionLinks = descriptionLinks
            self.descriptionMentions = descriptionMentions
            self.descriptionHashtags = descriptionHashtags
            self.linkColor = linkColor
            self.backgroundColor = backgroundColor
            self.statusesCount = statusesCount
            self.followersCount = followersCount
            self.friendsCount = friendsCount
            self.favoritesCount = favoritesCount
            self.mediaCount = mediaCount
            self.listsCount = listsCount
            self.listedCount = listedCount
            self.groupsCount = groupsCount
        }
        // Append body content
    
        // Sub models
    
    }
}
