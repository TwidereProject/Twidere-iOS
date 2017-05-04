//
//  MicroBlogUser.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/1.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse
class MicroBlogUser {
    
    // BEGIN Basic information
    
    // sourcery: jsonField=id
    var id: String!
    
    /**
     * Fanfou uses this ID
     */
    // sourcery: jsonField=unique_id
    var uniqueId: String? = nil
    
    // sourcery: jsonField=created_at
    // sourcery: jsonFieldConverter=TwitterDateFieldConverter
    var createdAt: Date!
    
    // sourcery: jsonField=name
    var name: String!
    
    // sourcery: jsonField=screen_name
    var screenName: String!
    
    // sourcery: jsonField=location
    var location: String? = nil
    
    // sourcery: jsonField=description
    var description: String? = nil
    
    // sourcery: jsonField=url
    var url: String? = nil
    
    // END Basic information
    
    // sourcery: jsonField=entities
    var entities: TwitterUserEntities? = nil
    
    // sourcery: jsonField=protected
    var isProtected: Bool = false
    
    // sourcery: jsonField=followers_count
    var followersCount: Int64 = -1
    
    // sourcery: jsonField=friends_count
    var friendsCount: Int64 = -1
    
    // sourcery: jsonField=listed_count
    var listedCount: Int64 = -1
    
    // sourcery: jsonField=groups_count
    var groupsCount: Int64 = -1
    
    // sourcery: jsonField=favourites_count
    var favouritesCount: Int64 = -1
    
    // sourcery: jsonField=utc_offset
    var utcOffset: Int32 = 0
    
    // sourcery: jsonField=time_zone
    var timeZone: String? = nil
    
    // sourcery: jsonField=geo_enabled
    var geoEnabled: Bool = false
    
    // sourcery: jsonField=verified
    var isVerified: Bool = false
    
    // sourcery: jsonField=statuses_count
    var statusesCount: Int64 = -1
    
    /**
     * `photo_count` is for Fanfou compatibility
     */
    // sourcery: jsonField=media_count|photo_count
    var mediaCount: Int64 = -1
    
    // sourcery: jsonField=lang
    var lang: String? = nil
    
    // sourcery: jsonField=status
    var status: MicroBlogStatus? = nil
    
    // sourcery: jsonField=contributors_enabled
    var contributorsEnabled: Bool = false
    
    // sourcery: jsonField=is_translator
    var isTranslator: Bool = false
    
    // sourcery: jsonField=is_translation_enabled
    var isTranslationEnabled: Bool = false
    
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonField=profile_background_color|backgroundcolor
    var profileBackgroundColor: String? = nil
    
    // sourcery: jsonField=profile_background_image_url
    var profileBackgroundImageUrl: String? = nil
    
    // sourcery: jsonField=profile_background_image_url_https
    var profileBackgroundImageUrlHttps: String? = nil
    
    // sourcery: jsonField=profile_background_tile
    var profileBackgroundTile: Bool = false
    
    // sourcery: jsonField=profile_image_url
    var profileImageUrl: String? = nil
    
    // sourcery: jsonField=profile_image_url_https
    var profileImageUrlHttps: String? = nil
    
    /**
     * Fanfou has field `"profile_image_url_large"`
     * GNU Social has field `"profile_image_url_profile_size"`
     */
    // sourcery: jsonField=profile_image_url_large|profile_image_url_profile_size
    var profileImageUrlLarge: String? = nil
    
    // sourcery: jsonField=profile_banner_url|cover_photo
    var profileBannerUrl: String? = nil
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonField=profile_link_color|linkcolor
    var profileLinkColor: String? = nil
    
    // sourcery: jsonField=profile_sidebar_border_color
    var profileSidebarBorderColor: String? = nil
    
    // sourcery: jsonField=profile_sidebar_fill_color
    var profileSidebarFillColor: String? = nil
    
    // sourcery: jsonField=profile_text_color
    var profileTextColor: String? = nil
    
    // sourcery: jsonField=profile_use_background_image
    var profileUseBackgroundImage: Bool = false
    
    // sourcery: jsonField=default_profile
    var defaultProfile: Bool = false
    
    // sourcery: jsonField=default_profile_image
    var defaultProfileImage: Bool = false
    
    // sourcery: jsonField=has_custom_timelines
    var hasCustomTimelines: Bool = false
    
    // sourcery: jsonField=suspended
    var isSuspended: Bool = false
    
    // sourcery: jsonField=needs_phone_verification
    var needsPhoneVerification: Bool = false
    
    // sourcery: jsonField=statusnet_profile_url
    var statusnetProfileUrl: String? = nil
    
    // sourcery: jsonField=ostatus_uri
    var ostatusUri: String? = nil
    
    // sourcery: jsonField=profile_image_url_original
    var profileImageUrlOriginal: String? = nil
    
    // BEGIN Twitter fields
    
    // sourcery: jsonField=pinned_tweet_ids
    var pinnedTweetIds: [String]? = nil
    
    // END Twitter fields
    
    // BEGIN Relationship fields
    
    /**
     * `follows_you` is for GNU social compatibility
     */
    // sourcery: jsonField=followed_by|follows_you
    var followedBy: Bool? = nil
    
    // sourcery: jsonField=following
    var following: Bool? = nil
    
    /**
     * `blocks_you` is for GNU social compatibility
     */
    // sourcery: jsonField=blocked_by|blocks_you
    var blockedBy: Bool? = nil
    
    /**
     * `statusnet_blocking` is for GNU social compatibility
     */
    // sourcery: jsonField=blocking|statusnet_blocking
    var blocking: Bool? = nil
    
    // sourcery: jsonField=muting
    var muting: Bool? = nil
    
    // sourcery: jsonField=follow_request_sent
    var followRequestSent: Bool? = nil
    
    // sourcery: jsonField=notifications
    var notificationsEnabled: Bool? = nil
    
    // sourcery: jsonField=can_media_tag
    var canMediaTag: Bool? = nil
    
    required init() {
        
    }
    
}
