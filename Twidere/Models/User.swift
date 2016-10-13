// Automatically generated, DO NOT MODIFY
import Foundation

struct User {

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
    var profileBannerUrl: String? 
    var profileBackgroundUrl: String? 
    var descriptionPlain: String? 
    var descriptionDisplay: String? 
    var url: String? 
    var urlExpanded: String? 
    var location: String? 
    var metadata: User.Metadata? 
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
        var linkColor: String? 
        var backgroundColor: String? 
        var statusesCount: Int64 = -1 
        var followersCount: Int64 = -1 
        var friendsCount: Int64 = -1 
        var favoritesCount: Int64 = -1 
        var mediaCount: Int64 = -1 
        var listsCount: Int64 = -1 
        var listedCount: Int64 = -1 
        var groupsCount: Int64 = -1 
        // Append body content
    
        // Sub models
    
    
    }

}
