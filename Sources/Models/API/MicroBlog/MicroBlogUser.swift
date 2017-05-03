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
    
    // sourcery: jsonFieldName=id
    var id: String!
    
    /**
     * Fanfou uses this ID
     */
    // sourcery: jsonFieldName=unique_id
    var uniqueId: String? = nil
    
    // sourcery: jsonFieldName=created_at
    // sourcery: jsonParseFunction=Date.parseTwitterDate
    var createdAt: Date!
    
    // sourcery: jsonFieldName=name
    var name: String!
    
    // sourcery: jsonFieldName=screen_name
    var screenName: String!
    
    // sourcery: jsonFieldName=location
    var location: String? = nil
    
    // sourcery: jsonFieldName=description
    var description: String? = nil
    
    // sourcery: jsonFieldName=url
    var url: String? = nil
    
    // END Basic information
    
    // sourcery: jsonFieldName=entities
    var entities: TwitterUserEntities? = nil
    
    // sourcery: jsonFieldName=protected
    var isProtected: Bool = false
    
    // sourcery: jsonFieldName=followers_count
    var followersCount: Int64 = -1
    
    // sourcery: jsonFieldName=friends_count
    var friendsCount: Int64 = -1
    
    // sourcery: jsonFieldName=listed_count
    var listedCount: Int64 = -1
    
    // sourcery: jsonFieldName=groups_count
    var groupsCount: Int64 = -1
    
    // sourcery: jsonFieldName=favourites_count
    var favouritesCount: Int64 = -1
    
    // sourcery: jsonFieldName=utc_offset
    var utcOffset: Int32 = 0
    
    // sourcery: jsonFieldName=time_zone
    var timeZone: String? = nil
    
    // sourcery: jsonFieldName=geo_enabled
    var geoEnabled: Bool = false
    
    // sourcery: jsonFieldName=verified
    var isVerified: Bool = false
    
    // sourcery: jsonFieldName=statuses_count
    var statusesCount: Int64 = -1
    
    /**
     * `photo_count` is for Fanfou compatibility
     */
    // sourcery: jsonFieldName=media_count|photo_count
    var mediaCount: Int64 = -1
    
    // sourcery: jsonFieldName=lang
    var lang: String? = nil
    
    // sourcery: jsonFieldName=status
    var status: MicroBlogStatus? = nil
    
    // sourcery: jsonFieldName=contributors_enabled
    var contributorsEnabled: Bool = false
    
    // sourcery: jsonFieldName=is_translator
    var isTranslator: Bool = false
    
    // sourcery: jsonFieldName=is_translation_enabled
    var isTranslationEnabled: Bool = false
    
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonFieldName=profile_background_color|backgroundcolor
    var profileBackgroundColor: String? = nil
    
    // sourcery: jsonFieldName=profile_background_image_url
    var profileBackgroundImageUrl: String? = nil
    
    // sourcery: jsonFieldName=profile_background_image_url_https
    var profileBackgroundImageUrlHttps: String? = nil
    
    // sourcery: jsonFieldName=profile_background_tile
    var profileBackgroundTile: Bool = false
    
    // sourcery: jsonFieldName=profile_image_url
    var profileImageUrl: String? = nil
    
    // sourcery: jsonFieldName=profile_image_url_https
    var profileImageUrlHttps: String? = nil
    
    /**
     * Fanfou has field `"profile_image_url_large"`
     * GNU Social has field `"profile_image_url_profile_size"`
     */
    // sourcery: jsonFieldName=profile_image_url_large|profile_image_url_profile_size
    var profileImageUrlLarge: String? = nil
    
    // sourcery: jsonFieldName=profile_banner_url|cover_photo
    var profileBannerUrl: String? = nil
    /**
     * `backgroundcolor` is for GNU social compatibility
     */
    // sourcery: jsonFieldName=profile_link_color|linkcolor
    var profileLinkColor: String? = nil
    
    // sourcery: jsonFieldName=profile_sidebar_border_color
    var profileSidebarBorderColor: String? = nil
    
    // sourcery: jsonFieldName=profile_sidebar_fill_color
    var profileSidebarFillColor: String? = nil
    
    // sourcery: jsonFieldName=profile_text_color
    var profileTextColor: String? = nil
    
    // sourcery: jsonFieldName=profile_use_background_image
    var profileUseBackgroundImage: Bool = false
    
    // sourcery: jsonFieldName=default_profile
    var defaultProfile: Bool = false
    
    // sourcery: jsonFieldName=default_profile_image
    var defaultProfileImage: Bool = false
    
    // sourcery: jsonFieldName=has_custom_timelines
    var hasCustomTimelines: Bool = false
    
    // sourcery: jsonFieldName=suspended
    var isSuspended: Bool = false
    
    // sourcery: jsonFieldName=needs_phone_verification
    var needsPhoneVerification: Bool = false
    
    // sourcery: jsonFieldName=statusnet_profile_url
    var statusnetProfileUrl: String? = nil
    
    // sourcery: jsonFieldName=ostatus_uri
    var ostatusUri: String? = nil
    
    // sourcery: jsonFieldName=profile_image_url_original
    var profileImageUrlOriginal: String? = nil
    
    // BEGIN Twitter fields
    
    // sourcery: jsonFieldName=pinned_tweet_ids
    var pinnedTweetIds: [String]? = nil
    
    // END Twitter fields
    
    // BEGIN Relationship fields
    
    /**
     * `follows_you` is for GNU social compatibility
     */
    // sourcery: jsonFieldName=followed_by|follows_you
    var followedBy: Bool? = nil
    
    // sourcery: jsonFieldName=following
    var following: Bool? = nil
    
    /**
     * `blocks_you` is for GNU social compatibility
     */
    // sourcery: jsonFieldName=blocked_by|blocks_you
    var blockedBy: Bool? = nil
    
    /**
     * `statusnet_blocking` is for GNU social compatibility
     */
    // sourcery: jsonFieldName=blocking|statusnet_blocking
    var blocking: Bool? = nil
    
    // sourcery: jsonFieldName=muting
    var muting: Bool? = nil
    
    // sourcery: jsonFieldName=follow_request_sent
    var followRequestSent: Bool? = nil
    
    // sourcery: jsonFieldName=notifications
    var notificationsEnabled: Bool? = nil
    
    // sourcery: jsonFieldName=can_media_tag
    var canMediaTag: Bool? = nil
    
    required init() {
        
    }
    
}
