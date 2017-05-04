// sourcery: jsonParse
public class User {
    
    // BEGIN Basic information
    
    // sourcery: jsonField=id
    public var id: String!
    
    /**
     * Fanfou uses this ID
     */
    // sourcery: jsonField=unique_id
    public var uniqueId: String? = nil
    
    // sourcery: jsonField=created_at
    // sourcery: jsonFieldConverter=TwitterDateFieldConverter
    public var createdAt: Date!
    
    // sourcery: jsonField=name
    public var name: String!
    
    // sourcery: jsonField=screen_name
    public var screenName: String!
    
    // sourcery: jsonField=location
    public var location: String? = nil
    
    // sourcery: jsonField=description
    public var description: String? = nil
    
    // sourcery: jsonField=url
    public var url: String? = nil
    
    // END Basic information
    
    // sourcery: jsonField=entities
    public var entities: UserEntities? = nil
    
    // sourcery: jsonField=protected
    public var isProtected: Bool = false
    
    // sourcery: jsonField=followers_count
    public var followersCount: Int64 = -1
    
    // sourcery: jsonField=friends_count
    public var friendsCount: Int64 = -1
    
    // sourcery: jsonField=listed_count
    public var listedCount: Int64 = -1
    
    // sourcery: jsonField=groups_count
    public var groupsCount: Int64 = -1
    
    // sourcery: jsonField=favourites_count
    public var favouritesCount: Int64 = -1
    
    // sourcery: jsonField=utc_offset
    public var utcOffset: Int32 = 0
    
    // sourcery: jsonField=time_zone
    public var timeZone: String? = nil
    
    // sourcery: jsonField=geo_enabled
    public var geoEnabled: Bool = false
    
    // sourcery: jsonField=verified
    public var isVerified: Bool = false
    
    // sourcery: jsonField=statuses_count
    public var statusesCount: Int64 = -1
    
    /**
     * `photo_count` is for Fanfou compatibility
     */
    // sourcery: jsonField=media_count|photo_count
    public var mediaCount: Int64 = -1
    
    // sourcery: jsonField=lang
    public var lang: String? = nil
    
    // sourcery: jsonField=status
    public var status: Status? = nil
    
    // sourcery: jsonField=contributors_enabled
    public var contributorsEnabled: Bool = false
    
    // sourcery: jsonField=is_translator
    public var isTranslator: Bool = false
    
    // sourcery: jsonField=is_translation_enabled
    public var isTranslationEnabled: Bool = false
    
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonField=profile_background_color|backgroundcolor
    public var profileBackgroundColor: String? = nil
    
    // sourcery: jsonField=profile_background_image_url
    public var profileBackgroundImageUrl: String? = nil
    
    // sourcery: jsonField=profile_background_image_url_https
    public var profileBackgroundImageUrlHttps: String? = nil
    
    // sourcery: jsonField=profile_background_tile
    public var profileBackgroundTile: Bool = false
    
    // sourcery: jsonField=profile_image_url
    public var profileImageUrl: String? = nil
    
    // sourcery: jsonField=profile_image_url_https
    public var profileImageUrlHttps: String? = nil
    
    /**
     * Fanfou has field `"profile_image_url_large"`
     * GNU Social has field `"profile_image_url_profile_size"`
     */
    // sourcery: jsonField=profile_image_url_large|profile_image_url_profile_size
    public var profileImageUrlLarge: String? = nil
    
    // sourcery: jsonField=profile_banner_url|cover_photo
    public var profileBannerUrl: String? = nil
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonField=profile_link_color|linkcolor
    public var profileLinkColor: String? = nil
    
    // sourcery: jsonField=profile_sidebar_border_color
    public var profileSidebarBorderColor: String? = nil
    
    // sourcery: jsonField=profile_sidebar_fill_color
    public var profileSidebarFillColor: String? = nil
    
    // sourcery: jsonField=profile_text_color
    public var profileTextColor: String? = nil
    
    // sourcery: jsonField=profile_use_background_image
    public var profileUseBackgroundImage: Bool = false
    
    // sourcery: jsonField=default_profile
    public var defaultProfile: Bool = false
    
    // sourcery: jsonField=default_profile_image
    public var defaultProfileImage: Bool = false
    
    // sourcery: jsonField=has_custom_timelines
    public var hasCustomTimelines: Bool = false
    
    // sourcery: jsonField=suspended
    public var isSuspended: Bool = false
    
    // sourcery: jsonField=needs_phone_verification
    public var needsPhoneVerification: Bool = false
    
    // sourcery: jsonField=statusnet_profile_url
    public var statusnetProfileUrl: String? = nil
    
    // sourcery: jsonField=ostatus_uri
    public var ostatusUri: String? = nil
    
    // sourcery: jsonField=profile_image_url_original
    public var profileImageUrlOriginal: String? = nil
    
    // BEGIN Twitter fields
    
    // sourcery: jsonField=pinned_tweet_ids
    public var pinnedTweetIds: [String]? = nil
    
    // END Twitter fields
    
    // BEGIN Relationship fields
    
    /**
     * `follows_you` is for GNU social compatibility
     */
    // sourcery: jsonField=followed_by|follows_you
    public var followedBy: Bool? = nil
    
    // sourcery: jsonField=following
    public var following: Bool? = nil
    
    /**
     * `blocks_you` is for GNU social compatibility
     */
    // sourcery: jsonField=blocked_by|blocks_you
    public var blockedBy: Bool? = nil
    
    /**
     * `statusnet_blocking` is for GNU social compatibility
     */
    // sourcery: jsonField=blocking|statusnet_blocking
    public var blocking: Bool? = nil
    
    // sourcery: jsonField=muting
    public var muting: Bool? = nil
    
    // sourcery: jsonField=follow_request_sent
    public var followRequestSent: Bool? = nil
    
    // sourcery: jsonField=notifications
    public var notificationsEnabled: Bool? = nil
    
    // sourcery: jsonField=can_media_tag
    public var canMediaTag: Bool? = nil
    
    required public init() {
        
    }
    
}
