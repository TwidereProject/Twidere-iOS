//
//  PersistableUser.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

//sourcery: jsonParse
public class PersistableUser {
    
    // sourcery: jsonField=account_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    public var account_key: UserKey? = nil
    
    public var account_color: Int = 0
    
    //@CursorField(value = CachedUsers._ID, type = TwidereDataStore.TYPE_PRIMARY_KEY, excludeWrite = true)
    public var _id: Int64 = 0
    
    // sourcery: jsonField=key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = CachedUsers.USER_KEY, converter = UserKeyCursorFieldConverter::class)
    public var key: UserKey!
    // sourcery: jsonField=created_at
    //@CursorField(CachedUsers.CREATED_AT)
    public var created_at: Int64 = 0
    // sourcery: jsonField=position
    public var position: Int64 = 0
    
    // sourcery: jsonField=is_protected
    //@CursorField(CachedUsers.IS_PROTECTED)
    public var is_protected: Bool = false
    // sourcery: jsonField=is_verified
    //@CursorField(CachedUsers.IS_VERIFIED)
    public var is_verified: Bool = false
    // sourcery: jsonField=is_follow_request_sent
    public var is_follow_request_sent: Bool = false
    // sourcery: jsonField=is_following
    //@CursorField(CachedUsers.IS_FOLLOWING)
    public var is_following: Bool = false
    
    // sourcery: jsonField=description_plain
    //@CursorField(CachedUsers.DESCRIPTION_PLAIN)
    public var description_plain: String? = nil
    // sourcery: jsonField=name
    //@CursorField(CachedUsers.NAME)
    public var name: String!
    // sourcery: jsonField=screen_name
    //@CursorField(CachedUsers.SCREEN_NAME)
    public var screen_name: String!
    // sourcery: jsonField=location
    //@CursorField(CachedUsers.LOCATION)
    public var location: String? = nil
    // sourcery: jsonField=profile_image_url
    //@CursorField(CachedUsers.PROFILE_IMAGE_URL)
    public var profile_image_url: String!
    // sourcery: jsonField=profile_banner_url
    //@CursorField(CachedUsers.PROFILE_BANNER_URL)
    public var profile_banner_url: String? = nil
    // sourcery: jsonField=profile_background_url
    //@CursorField(CachedUsers.PROFILE_BACKGROUND_URL)
    public var profile_background_url: String? = nil
    // sourcery: jsonField=url
    //@CursorField(CachedUsers.URL)
    public var url: String? = nil
    // sourcery: jsonField=url_expanded
    //@CursorField(CachedUsers.URL_EXPANDED)
    public var url_expanded: String? = nil
    // sourcery: jsonField=description_unescaped
    //@CursorField(CachedUsers.DESCRIPTION_UNESCAPED)
    public var description_unescaped: String? = nil
    
    // sourcery: jsonField=description_spans
    //@CursorField(value = CachedUsers.DESCRIPTION_SPANS, converter = LoganSquareCursorFieldConverter::class)
    public var description_spans: [SpanItem]? = nil
    
    // sourcery: jsonField=followers_count
    //@CursorField(CachedUsers.FOLLOWERS_COUNT)
    public var followers_count: Int64 = -1
    // sourcery: jsonField=friends_count
    //@CursorField(CachedUsers.FRIENDS_COUNT)
    public var friends_count: Int64 = -1
    // sourcery: jsonField=statuses_count
    //@CursorField(CachedUsers.STATUSES_COUNT)
    public var statuses_count: Int64 = -1
    // sourcery: jsonField=favorites_count
    //@CursorField(CachedUsers.FAVORITES_COUNT)
    public var favorites_count: Int64 = -1
    // sourcery: jsonField=listed_count
    //@CursorField(CachedUsers.LISTED_COUNT)
    public var listed_count: Int64 = -1
    // sourcery: jsonField=media_count
    //@CursorField(CachedUsers.MEDIA_COUNT)
    public var media_count: Int64 = -1
    
    // sourcery: jsonField=background_color
    // sourcery: jsonFieldConverter=ContentObjectColorConverter
    //@CursorField(CachedUsers.BACKGROUND_COLOR)
    public var background_color: Int = 0
    // sourcery: jsonField=link_color
    // sourcery: jsonFieldConverter=ContentObjectColorConverter
    //@CursorField(CachedUsers.LINK_COLOR)
    public var link_color: Int = 0
    // sourcery: jsonField=text_color
    // sourcery: jsonFieldConverter=ContentObjectColorConverter
    //@CursorField(CachedUsers.TEXT_COLOR)
    public var text_color: Int = 0
    
    // sourcery: jsonField=is_cache
    public var is_cache: Bool = false
    // sourcery: jsonField=is_basic
    public var is_basic: Bool = false
    
    // sourcery: jsonField=extras
    //@CursorField(value = CachedUsers.EXTRAS, converter = LoganSquareCursorFieldConverter::class)
    public var extras: Extras? = nil
    
    //@ParcelableNoThanks
    //@CursorField(CachedUsers.LAST_SEEN)
    public var last_seen: Int64 = 0
    
    //@ParcelableNoThanks
    //@CursorField(value = CachedUsers.SCORE, excludeWrite = true)
    public var score: Int = 0
    
    //@CursorField(value = CachedUsers.USER_TYPE)
    public var user_type: String? = nil
    
    public var color: Int = 0
    public var nickname: String? = nil
    
    public var is_filtered: Bool = false
    
    required public init() {
        
    }
    
    // sourcery: jsonParse
    public class Extras {
        
        // sourcery: jsonField=statusnet_profile_url
        public var statusnet_profile_url: String? = nil
        // sourcery: jsonField=ostatus_uri
        public var ostatus_uri: String? = nil
        // sourcery: jsonField=profile_image_url_original
        public var profile_image_url_original: String? = nil
        // sourcery: jsonField=profile_image_url_fallback
        public var profile_image_url_fallback: String? = nil
        // sourcery: jsonField=groups_count
        public var groups_count: Int64 = -1
        // sourcery: jsonField=unique_id
        public var unique_id: String? = nil
        // sourcery: jsonField=blocking
        public var blocking: Bool = false
        // sourcery: jsonField=blocked_by
        public var blocked_by: Bool = false
        // sourcery: jsonField=followed_by
        public var followed_by: Bool = false
        // sourcery: jsonField=muting
        public var muting: Bool = false
        // sourcery: jsonField=notifications_enabled
        public var notifications_enabled: Bool = false
        // sourcery: jsonField=pinned_status_ids
        public var pinned_status_ids: [String]? = nil
        
        required public init() {
            
        }
    }
}
