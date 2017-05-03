//
//  PersistableStatus.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

//@CursorObject(valuesCreator = true, tableInfo = true)
// sourcery:jsonParse
class ParcelableStatus {
    //@CursorField(value = Statuses._ID, excludeWrite = true, type = TwidereDataStore.TYPE_PRIMARY_KEY)
    var _id: Int64 = 0
    
    // sourcery: jsonFieldName=id
    //@CursorField(Statuses.ID)
    var id: String!
    
    //@CursorField(value = Statuses.ACCOUNT_KEY, converter = UserKeyCursorFieldConverter::class)
    // sourcery: jsonFieldName=account_key
    // sourcery: jsonParseFunction=UserKey.parse
    var account_key: UserKey!
    
    // sourcery: jsonFieldName=sort_id
    //@CursorField(Statuses.SORT_ID)
    var sort_id: Int64 = -1
    
    // sourcery: jsonFieldName=position_key
    //@CursorField(Statuses.POSITION_KEY)
    var position_key: Int64 = 0
    
    // sourcery: jsonFieldName=timestamp
    //@CursorField(Statuses.TIMESTAMP)
    var timestamp: Int64 = 0
    
    //@CursorField(value = Statuses.USER_KEY, converter = UserKeyCursorFieldConverter::class)
    // sourcery: jsonFieldName=user_key
    // sourcery: jsonParseFunction=UserKey.parse
    var user_key: UserKey!
    
    // sourcery: jsonFieldName=retweet_id
    //@CursorField(Statuses.RETWEET_ID)
    var retweet_id: String? = nil
    
    // sourcery: jsonFieldName=retweeted_by_user_key
    // sourcery: jsonParseFunction=UserKey.parse
    //@CursorField(value = Statuses.RETWEETED_BY_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var retweeted_by_user_key: UserKey? = nil
    
    // sourcery: jsonFieldName=retweet_timestamp
    //@CursorField(Statuses.RETWEET_TIMESTAMP)
    var retweet_timestamp: Int64 = -1
    
    // sourcery: jsonFieldName=retweet_count
    //@CursorField(Statuses.RETWEET_COUNT)
    var retweet_count: Int64 = 0
    
    // sourcery: jsonFieldName=favorite_count
    //@CursorField(Statuses.FAVORITE_COUNT)
    var favorite_count: Int64 = 0
    
    // sourcery: jsonFieldName=reply_count
    //@CursorField(Statuses.REPLY_COUNT)
    var reply_count: Int64 = 0
    
    // sourcery: jsonFieldName=in_reply_to_status_id
    //@CursorField(Statuses.IN_REPLY_TO_STATUS_ID)
    var in_reply_to_status_id: String? = nil
    
    // sourcery: jsonFieldName=in_reply_to_user_key
    // sourcery: jsonParseFunction=UserKey.parse
    //@CursorField(value = Statuses.IN_REPLY_TO_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var in_reply_to_user_key: UserKey? = nil
    
    // sourcery: jsonFieldName=my_retweet_id
    //@CursorField(Statuses.MY_RETWEET_ID)
    var my_retweet_id: String? = nil
    
    // sourcery: jsonFieldName=quoted_id
    //@CursorField(Statuses.QUOTED_ID)
    var quoted_id: String? = nil
    
    // sourcery: jsonFieldName=quoted_timestamp
    //@CursorField(Statuses.QUOTED_TIMESTAMP)
    var quoted_timestamp: Int64 = 0
    
    // sourcery: jsonFieldName=quoted_user_key
    // sourcery: jsonParseFunction=UserKey.parse
    //@CursorField(value = Statuses.QUOTED_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var quoted_user_key: UserKey? = nil
    
    // sourcery: jsonFieldName=is_gap
    //@CursorField(Statuses.IS_GAP)
    var is_gap: Bool = false
    
    // sourcery: jsonFieldName=is_retweet
    //@CursorField(Statuses.IS_RETWEET)
    var is_retweet: Bool = false
    
    // sourcery: jsonFieldName=retweeted
    //@CursorField(Statuses.RETWEETED)
    var retweeted: Bool = false
    
    // sourcery: jsonFieldName=is_favorite
    //@CursorField(Statuses.IS_FAVORITE)
    var is_favorite: Bool = false
    
    // sourcery: jsonFieldName=is_possibly_sensitive
    //@CursorField(Statuses.IS_POSSIBLY_SENSITIVE)
    var is_possibly_sensitive: Bool = false
    
    // sourcery: jsonFieldName=user_is_following
    //@CursorField(Statuses.IS_FOLLOWING)
    var user_is_following: Bool = false
    
    // sourcery: jsonFieldName=user_is_protected
    //@CursorField(Statuses.IS_PROTECTED)
    var user_is_protected: Bool = false
    
    // sourcery: jsonFieldName=user_is_verified
    //@CursorField(Statuses.IS_VERIFIED)
    var user_is_verified: Bool = false
    
    // sourcery: jsonFieldName=is_quote
    //@CursorField(Statuses.IS_QUOTE)
    var is_quote: Bool = false
    
    // sourcery: jsonFieldName=quoted_user_is_protected
    //@CursorField(Statuses.QUOTED_USER_IS_PROTECTED)
    var quoted_user_is_protected: Bool = false
    
    // sourcery: jsonFieldName=quoted_user_is_verified
    //@CursorField(Statuses.QUOTED_USER_IS_VERIFIED)
    var quoted_user_is_verified: Bool = false
    
    // sourcery: jsonFieldName=retweeted_by_user_name
    //@CursorField(Statuses.RETWEETED_BY_USER_NAME)
    var retweeted_by_user_name: String? = nil
    
    // sourcery: jsonFieldName=retweeted_by_user_screen_name
    //@CursorField(Statuses.RETWEETED_BY_USER_SCREEN_NAME)
    var retweeted_by_user_screen_name: String? = nil
    
    // sourcery: jsonFieldName=retweeted_by_user_profile_image
    //@CursorField(Statuses.RETWEETED_BY_USER_PROFILE_IMAGE)
    var retweeted_by_user_profile_image: String? = nil
    
    // sourcery: jsonFieldName=text_plain
    //@CursorField(Statuses.TEXT_PLAIN)
    var text_plain: String? = nil
    
    // sourcery: jsonFieldName=lang
    //@CursorField(Statuses.LANG)
    var lang: String? = nil
    
    // sourcery: jsonFieldName=user_name
    //@CursorField(Statuses.USER_NAME)
    var user_name: String? = nil
    
    // sourcery: jsonFieldName=user_screen_name
    //@CursorField(Statuses.USER_SCREEN_NAME)
    var user_screen_name: String? = nil
    
    // sourcery: jsonFieldName=in_reply_to_name
    //@CursorField(Statuses.IN_REPLY_TO_USER_NAME)
    var in_reply_to_name: String? = nil
    
    // sourcery: jsonFieldName=in_reply_to_screen_name
    //@CursorField(Statuses.IN_REPLY_TO_USER_SCREEN_NAME)
    var in_reply_to_screen_name: String? = nil
    
    // sourcery: jsonFieldName=source
    //@CursorField(Statuses.SOURCE)
    var source: String? = nil
    
    // sourcery: jsonFieldName=user_profile_image_url
    //@CursorField(Statuses.USER_PROFILE_IMAGE)
    var user_profile_image_url: String? = nil
    
    // sourcery: jsonFieldName=text_unescaped
    //@CursorField(Statuses.TEXT_UNESCAPED)
    var text_unescaped: String? = nil
    // sourcery: jsonFieldName=card_name
    //@CursorField(Statuses.CARD_NAME)
    var card_name: String? = nil
    
    // sourcery: jsonFieldName=quoted_text_plain
    //@CursorField(Statuses.QUOTED_TEXT_PLAIN)
    var quoted_text_plain: String? = nil
    
    // sourcery: jsonFieldName=quoted_text_unescaped
    //@CursorField(Statuses.QUOTED_TEXT_UNESCAPED)
    var quoted_text_unescaped: String? = nil
    
    // sourcery: jsonFieldName=quoted_source
    //@CursorField(Statuses.QUOTED_SOURCE)
    var quoted_source: String? = nil
    
    // sourcery: jsonFieldName=quoted_user_name
    //@CursorField(Statuses.QUOTED_USER_NAME)
    var quoted_user_name: String? = nil
    
    // sourcery: jsonFieldName=quoted_user_screen_name
    //@CursorField(Statuses.QUOTED_USER_SCREEN_NAME)
    var quoted_user_screen_name: String? = nil
    
    // sourcery: jsonFieldName=quoted_user_profile_image
    //@CursorField(Statuses.QUOTED_USER_PROFILE_IMAGE)
    var quoted_user_profile_image: String? = nil
    
    // sourcery: jsonFieldName=location
    //@CursorField(value = Statuses.LOCATION, converter = ParcelableLocation.Converter::class)
    var location: ParcelableLocation? = nil
    
    // sourcery: jsonFieldName=place_full_name
    //@CursorField(value = Statuses.PLACE_FULL_NAME, converter = LoganSquareCursorFieldConverter::class)
    var place_full_name: String? = nil
    
    // sourcery: jsonFieldName=mentions
    //@CursorField(value = Statuses.MENTIONS_JSON, converter = LoganSquareCursorFieldConverter::class)
    var mentions: Array<ParcelableUserMention>? = nil
    
    // sourcery: jsonFieldName=media
    //@CursorField(value = Statuses.MEDIA_JSON, converter = LoganSquareCursorFieldConverter::class)
    var media: Array<ParcelableMedia>? = nil
    
    // sourcery: jsonFieldName=quoted_media
    //@CursorField(value = Statuses.QUOTED_MEDIA_JSON, converter = LoganSquareCursorFieldConverter::class)
    var quoted_media: Array<ParcelableMedia>? = nil
    // sourcery: jsonFieldName=card
    //@CursorField(value = Statuses.CARD, converter = LoganSquareCursorFieldConverter::class)
    var card: ParcelableCardEntity? = nil
    
    // sourcery: jsonFieldName=extras
    //@CursorField(value = Statuses.EXTRAS, converter = LoganSquareCursorFieldConverter::class)
    var extras: Extras? = nil
    
    // sourcery: jsonFieldName=spans
    //@CursorField(value = Statuses.SPANS, converter = LoganSquareCursorFieldConverter::class)
    var spans: Array<SpanItem>? = nil
    
    // sourcery: jsonFieldName=quoted_spans
    //@CursorField(value = Statuses.QUOTED_SPANS, converter = LoganSquareCursorFieldConverter::class)
    var quoted_spans: Array<SpanItem>? = nil
    
    // transient
    var is_filtered: Bool = false
    
    // sourcery: jsonFieldName=account_color
    //@CursorField(Statuses.ACCOUNT_COLOR)
    var account_color: Int = 0
    
    //@CursorField(Statuses.INSERTED_DATE)
    var inserted_date: Int64 = 0
    
    
    var is_pinned_status: Bool = false
    
    //@CursorField(Statuses.FILTER_FLAGS)
    var filter_flags: FilterFlags = []
    
    internal func finishCursorObjectCreation() {
    card_name = if (card != nil) card!!.name else nil
    fixSortId()
    }
    
    internal func onParseComplete() {
    fixSortId()
    }
    
    private func fixSortId() {
    if (sort_id <= 0) {
    try {
    sort_id = java.lang.Int64.parseInt64(id)
    } catch (e: NumberFormatException) {
    // Ignore
    }
    
    }
    if (sort_id <= 0) {
    sort_id = timestamp
    }
    }
    
    // sourcery:jsonParse
    class Extras {
        // sourcery: jsonFieldName=external_url
        var external_url: String? = nil
        // sourcery: jsonFieldName=quoted_external_url
        var quoted_external_url: String? = nil
        // sourcery: jsonFieldName=retweeted_external_url
        var retweeted_external_url: String? = nil
        // sourcery: jsonFieldName=statusnet_conversation_id
        var statusnet_conversation_id: String? = nil
        // sourcery: jsonFieldName=support_entities
        var support_entities: Bool = false
        // sourcery: jsonFieldName=user_profile_image_url_fallback
        var user_profile_image_url_fallback: String? = nil
        // sourcery: jsonFieldName=user_statusnet_profile_url
        var user_statusnet_profile_url: String? = nil
        // sourcery: jsonFieldName=display_text_range
        var display_text_range: [Int32]? = nil
        // sourcery: jsonFieldName=quoted_display_text_range
        var quoted_display_text_range: [Int32]? = nil
        // sourcery: jsonFieldName=conversation_id
        var conversation_id: String? = nil
        // sourcery: jsonFieldName=summary_text
        var summary_text: String? = nil
        // sourcery: jsonFieldName=visibility
        var visibility: String? = nil
        
        required init() {
            
        }
        
    }
    
    /**
     * Flags for filtering some kind of tweet.
     * We use bitwise operations against string comparisons because it's much faster.
     *
     *
     * DO NOT CHANGE ONCE DEFINED!
     */
    struct FilterFlags: OptionSet {
        
        let rawValue: UInt32
        
        /**
         * Original tweet of a quote tweet is unavailable.
         * Happens when:
         *
         *
         *  * You were blocked by this user
         *  * You blocked/muted this user
         *  * Original tweet was marked sensitive and your account settings blocked them
         *  * Original tweet was deleted
         *  * Original tweet author blocked or blocked by quoted tweet author
         */
        static let quoteNotAvailable = FilterFlags(rawValue: 0x1)
        /**
         * Original author of a quote/retweet was blocked by you
         */
        static let blockingUser = FilterFlags(rawValue: 0x2)
        /**
         * You were blocked by original author of a quote/retweet
         */
        static let blockedByUser = FilterFlags(rawValue: 0x4)
        /**
         * Status possibly sensitive (NSFW etc)
         */
        static let possiblySensitive = FilterFlags(rawValue: 0x8)
        
    }
    
    
    static func calculateHashCode(accountKey: UserKey, id: String) -> Int {
        var result = id.hashCode()
        result = 31 * result + accountKey.hashCode()
        return result
    }
    
}
