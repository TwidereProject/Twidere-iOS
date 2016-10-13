// Automatically generated, DO NOT MODIFY
import Foundation

struct User {

    // Fields
    var _id: Int64 
    var accountKey: UserKey 
    var key: UserKey 
    var createdAt: Date 
    var position: Int64 
    var isProtected: Bool 
    var isVerified: Bool 
    var name: String 
    var screenName: String 
    var profileImageUrl: String 
    var profileBannerUrl: String 
    var profileBackgroundUrl: String 
    var descriptionPlain: String 
    var descriptionDisplay: String 
    var url: String 
    var urlExpanded: String 
    var location: String 
    var metadata: User.Metadata 
    // Append body content

    // Sub models
    struct Metadata {
    
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
        var linkColor: String 
        var backgroundColor: String 
        var statusesCount: Int64 
        var followersCount: Int64 
        var friendsCount: Int64 
        var favoritesCount: Int64 
        var mediaCount: Int64 
        var listsCount: Int64 
        var listedCount: Int64 
        var groupsCount: Int64 
        // Append body content
    
        // Sub models
    
    
    }

}
