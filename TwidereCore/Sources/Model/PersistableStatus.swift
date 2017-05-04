//
//  PersistableStatus.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import MicroBlog

//@CursorObject(valuesCreator = true, tableInfo = true)
// sourcery:jsonParse
public class PersistableStatus {
    //@CursorField(value = Statuses._ID, excludeWrite = true, type = TwidereDataStore.TYPE_PRIMARY_KEY)
    var _id: Int64 = 0
    
    // sourcery: jsonField=id
    //@CursorField(Statuses.ID)
    var id: String!
    
    //@CursorField(value = Statuses.ACCOUNT_KEY, converter = UserKeyCursorFieldConverter::class)
    // sourcery: jsonField=account_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    var account_key: UserKey!
    
    // sourcery: jsonField=sort_id
    //@CursorField(Statuses.SORT_ID)
    var sort_id: Int64 = -1
    
    // sourcery: jsonField=position_key
    //@CursorField(Statuses.POSITION_KEY)
    var position_key: Int64 = 0
    
    // sourcery: jsonField=timestamp
    //@CursorField(Statuses.TIMESTAMP)
    var timestamp: Int64 = 0
    
    //@CursorField(value = Statuses.USER_KEY, converter = UserKeyCursorFieldConverter::class)
    // sourcery: jsonField=user_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    var user_key: UserKey!
    
    // sourcery: jsonField=retweet_id
    //@CursorField(Statuses.RETWEET_ID)
    var retweet_id: String? = nil
    
    // sourcery: jsonField=retweeted_by_user_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = Statuses.RETWEETED_BY_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var retweeted_by_user_key: UserKey? = nil
    
    // sourcery: jsonField=retweet_timestamp
    //@CursorField(Statuses.RETWEET_TIMESTAMP)
    var retweet_timestamp: Int64 = -1
    
    // sourcery: jsonField=retweet_count
    //@CursorField(Statuses.RETWEET_COUNT)
    var retweet_count: Int64 = 0
    
    // sourcery: jsonField=favorite_count
    //@CursorField(Statuses.FAVORITE_COUNT)
    var favorite_count: Int64 = 0
    
    // sourcery: jsonField=reply_count
    //@CursorField(Statuses.REPLY_COUNT)
    var reply_count: Int64 = 0
    
    // sourcery: jsonField=in_reply_to_status_id
    //@CursorField(Statuses.IN_REPLY_TO_STATUS_ID)
    var in_reply_to_status_id: String? = nil
    
    // sourcery: jsonField=in_reply_to_user_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = Statuses.IN_REPLY_TO_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var in_reply_to_user_key: UserKey? = nil
    
    // sourcery: jsonField=my_retweet_id
    //@CursorField(Statuses.MY_RETWEET_ID)
    var my_retweet_id: String? = nil
    
    // sourcery: jsonField=quoted_id
    //@CursorField(Statuses.QUOTED_ID)
    var quoted_id: String? = nil
    
    // sourcery: jsonField=quoted_timestamp
    //@CursorField(Statuses.QUOTED_TIMESTAMP)
    var quoted_timestamp: Int64 = 0
    
    // sourcery: jsonField=quoted_user_key
    // sourcery: jsonFieldConverter=UserKeyFieldConverter
    //@CursorField(value = Statuses.QUOTED_USER_KEY, converter = UserKeyCursorFieldConverter::class)
    var quoted_user_key: UserKey? = nil
    
    // sourcery: jsonField=is_gap
    //@CursorField(Statuses.IS_GAP)
    var is_gap: Bool = false
    
    // sourcery: jsonField=is_retweet
    //@CursorField(Statuses.IS_RETWEET)
    var is_retweet: Bool = false
    
    // sourcery: jsonField=retweeted
    //@CursorField(Statuses.RETWEETED)
    var retweeted: Bool = false
    
    // sourcery: jsonField=is_favorite
    //@CursorField(Statuses.IS_FAVORITE)
    var is_favorite: Bool = false
    
    // sourcery: jsonField=is_possibly_sensitive
    //@CursorField(Statuses.IS_POSSIBLY_SENSITIVE)
    var is_possibly_sensitive: Bool = false
    
    // sourcery: jsonField=user_is_following
    //@CursorField(Statuses.IS_FOLLOWING)
    var user_is_following: Bool = false
    
    // sourcery: jsonField=user_is_protected
    //@CursorField(Statuses.IS_PROTECTED)
    var user_is_protected: Bool = false
    
    // sourcery: jsonField=user_is_verified
    //@CursorField(Statuses.IS_VERIFIED)
    var user_is_verified: Bool = false
    
    // sourcery: jsonField=is_quote
    //@CursorField(Statuses.IS_QUOTE)
    var is_quote: Bool = false
    
    // sourcery: jsonField=quoted_user_is_protected
    //@CursorField(Statuses.QUOTED_USER_IS_PROTECTED)
    var quoted_user_is_protected: Bool = false
    
    // sourcery: jsonField=quoted_user_is_verified
    //@CursorField(Statuses.QUOTED_USER_IS_VERIFIED)
    var quoted_user_is_verified: Bool = false
    
    // sourcery: jsonField=retweeted_by_user_name
    //@CursorField(Statuses.RETWEETED_BY_USER_NAME)
    var retweeted_by_user_name: String? = nil
    
    // sourcery: jsonField=retweeted_by_user_screen_name
    //@CursorField(Statuses.RETWEETED_BY_USER_SCREEN_NAME)
    var retweeted_by_user_screen_name: String? = nil
    
    // sourcery: jsonField=retweeted_by_user_profile_image
    //@CursorField(Statuses.RETWEETED_BY_USER_PROFILE_IMAGE)
    var retweeted_by_user_profile_image: String? = nil
    
    // sourcery: jsonField=text_plain
    //@CursorField(Statuses.TEXT_PLAIN)
    var text_plain: String? = nil
    
    // sourcery: jsonField=lang
    //@CursorField(Statuses.LANG)
    var lang: String? = nil
    
    // sourcery: jsonField=user_name
    //@CursorField(Statuses.USER_NAME)
    var user_name: String? = nil
    
    // sourcery: jsonField=user_screen_name
    //@CursorField(Statuses.USER_SCREEN_NAME)
    var user_screen_name: String? = nil
    
    // sourcery: jsonField=in_reply_to_name
    //@CursorField(Statuses.IN_REPLY_TO_USER_NAME)
    var in_reply_to_name: String? = nil
    
    // sourcery: jsonField=in_reply_to_screen_name
    //@CursorField(Statuses.IN_REPLY_TO_USER_SCREEN_NAME)
    var in_reply_to_screen_name: String? = nil
    
    // sourcery: jsonField=source
    //@CursorField(Statuses.SOURCE)
    var source: String? = nil
    
    // sourcery: jsonField=user_profile_image_url
    //@CursorField(Statuses.USER_PROFILE_IMAGE)
    var user_profile_image_url: String? = nil
    
    // sourcery: jsonField=text_unescaped
    //@CursorField(Statuses.TEXT_UNESCAPED)
    var text_unescaped: String? = nil
    // sourcery: jsonField=card_name
    //@CursorField(Statuses.CARD_NAME)
    var card_name: String? = nil
    
    // sourcery: jsonField=quoted_text_plain
    //@CursorField(Statuses.QUOTED_TEXT_PLAIN)
    var quoted_text_plain: String? = nil
    
    // sourcery: jsonField=quoted_text_unescaped
    //@CursorField(Statuses.QUOTED_TEXT_UNESCAPED)
    var quoted_text_unescaped: String? = nil
    
    // sourcery: jsonField=quoted_source
    //@CursorField(Statuses.QUOTED_SOURCE)
    var quoted_source: String? = nil
    
    // sourcery: jsonField=quoted_user_name
    //@CursorField(Statuses.QUOTED_USER_NAME)
    var quoted_user_name: String? = nil
    
    // sourcery: jsonField=quoted_user_screen_name
    //@CursorField(Statuses.QUOTED_USER_SCREEN_NAME)
    var quoted_user_screen_name: String? = nil
    
    // sourcery: jsonField=quoted_user_profile_image
    //@CursorField(Statuses.QUOTED_USER_PROFILE_IMAGE)
    var quoted_user_profile_image: String? = nil
    
    // sourcery: jsonField=location
    // sourcery: jsonFieldConverter=GeoLocationFieldConverter
    //@CursorField(value = Statuses.LOCATION, converter = ParcelableLocation.Converter::class)
    var location: GeoLocation? = nil
    
    // sourcery: jsonField=place_full_name
    //@CursorField(value = Statuses.PLACE_FULL_NAME, converter = LoganSquareCursorFieldConverter::class)
    var place_full_name: String? = nil
    
    // sourcery: jsonField=mentions
    //@CursorField(value = Statuses.MENTIONS_JSON, converter = LoganSquareCursorFieldConverter::class)
    var mentions: [MentionItem]? = nil
    
    // sourcery: jsonField=media
    //@CursorField(value = Statuses.MEDIA_JSON, converter = LoganSquareCursorFieldConverter::class)
    var media: [MediaItem]? = nil
    
    // sourcery: jsonField=quoted_media
    //@CursorField(value = Statuses.QUOTED_MEDIA_JSON, converter = LoganSquareCursorFieldConverter::class)
    var quoted_media: [MediaItem]? = nil
    // sourcery: jsonField=card
    //@CursorField(value = Statuses.CARD, converter = LoganSquareCursorFieldConverter::class)
    var card: PersistableCardEntity? = nil
    
    // sourcery: jsonField=extras
    //@CursorField(value = Statuses.EXTRAS, converter = LoganSquareCursorFieldConverter::class)
    var extras: Extras? = nil
    
    // sourcery: jsonField=spans
    //@CursorField(value = Statuses.SPANS, converter = LoganSquareCursorFieldConverter::class)
    var spans: [SpanItem]? = nil
    
    // sourcery: jsonField=quoted_spans
    //@CursorField(value = Statuses.QUOTED_SPANS, converter = LoganSquareCursorFieldConverter::class)
    var quoted_spans: [SpanItem]? = nil
    
    // transient
    var is_filtered: Bool = false
    
    // sourcery: jsonField=account_color
    //@CursorField(Statuses.ACCOUNT_COLOR)
    var account_color: Int = 0
    
    //@CursorField(Statuses.INSERTED_DATE)
    var inserted_date: Int64 = 0
    
    var is_pinned_status: Bool = false
    
    //@CursorField(Statuses.FILTER_FLAGS)
    var filter_flags: FilterFlag = []
    
    internal func finishCursorObjectCreation() {
        card_name = card?.name
        fixSortId()
    }
    
    internal func onParseComplete() {
        fixSortId()
    }
    
    required public init() {
        
    }
    
    private func fixSortId() {
        if (sort_id <= 0) {
            sort_id = Int64(id) ?? -1
        }
        if (sort_id <= 0) {
            sort_id = timestamp
        }
    }
    
    // sourcery:jsonParse
    class Extras {
        // sourcery: jsonField=external_url
        var external_url: String? = nil
        // sourcery: jsonField=quoted_external_url
        var quoted_external_url: String? = nil
        // sourcery: jsonField=retweeted_external_url
        var retweeted_external_url: String? = nil
        // sourcery: jsonField=statusnet_conversation_id
        var statusnet_conversation_id: String? = nil
        // sourcery: jsonField=support_entities
        var support_entities: Bool = false
        // sourcery: jsonField=user_profile_image_url_fallback
        var user_profile_image_url_fallback: String? = nil
        // sourcery: jsonField=user_statusnet_profile_url
        var user_statusnet_profile_url: String? = nil
        // sourcery: jsonField=display_text_range
        var display_text_range: [Int]? = nil
        // sourcery: jsonField=quoted_display_text_range
        var quoted_display_text_range: [Int]? = nil
        // sourcery: jsonField=conversation_id
        var conversation_id: String? = nil
        // sourcery: jsonField=summary_text
        var summary_text: String? = nil
        // sourcery: jsonField=visibility
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
    struct FilterFlag: OptionSet {
        
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
        static let quoteNotAvailable = FilterFlag(rawValue: 0x1)
        /**
         * Original author of a quote/retweet was blocked by you
         */
        static let blockingUser = FilterFlag(rawValue: 0x2)
        /**
         * You were blocked by original author of a quote/retweet
         */
        static let blockedByUser = FilterFlag(rawValue: 0x4)
        /**
         * Status possibly sensitive (NSFW etc)
         */
        static let possiblySensitive = FilterFlag(rawValue: 0x8)
        
    }
    
    static func calculateHashCode(accountKey: UserKey, id: String) -> Int {
        var result = id.hashValue
        result = 31 * result + accountKey.hashValue
        return result
    }
    
}
