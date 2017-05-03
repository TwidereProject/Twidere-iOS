//
//  Status.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/4/30.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

// sourcery: jsonParse,jsonSerialize
class MicroBlogStatus: TwitterEntitySupport {

    // sourcery: jsonFieldName=created_at
    // sourcery: jsonFieldConverter=TwitterDateFieldConverter
    var createdAt: Date!

    // sourcery: jsonFieldName=id
    var id: String!
    
    // Fanfou uses this key
    // sourcery: jsonFieldName=rawid
    var rawId: Int64 = -1
    
    // sourcery: jsonFieldName=text
    var text: String!
    
    /**
     * https://dev.twitter.com/overview/api/upcoming-changes-to-tweets
     */
    // sourcery: jsonFieldName=full_text
    var fullText: String!
    
    // sourcery: jsonFieldName=statusnet_html
    var statusnetHtml: String!
    
    // sourcery: jsonFieldName=source
    var source: String? = nil
    
    // sourcery: jsonFieldName=truncated
    var truncated: Bool = false
    
    // sourcery: jsonFieldName=entities
    var entities: TwitterEntities? = nil
    
    // sourcery: jsonFieldName=extended_entities
    var extendedEntities: TwitterEntities? = nil
    
    // sourcery: jsonFieldName=in_reply_to_status_id
    var inReplyToStatusId: String?
    
    // sourcery: jsonFieldName=in_reply_to_user_id
    var inReplyToUserId: String?
    
    // sourcery: jsonFieldName=in_reply_to_screen_name
    var inReplyToScreenName: String?
    
    // sourcery: jsonFieldName=user
    var user: MicroBlogUser! = nil
    
    // sourcery: jsonFieldName=geo
    var geo: MicroBlogGeoPoint? = nil
    
    // sourcery: jsonFieldName=place
    var place: MicroBlogPlace? = nil
    
    // sourcery: jsonFieldName=current_user_retweet
    var currentUserRetweet: CurrentUserRetweet? = nil
    
    // sourcery: jsonFieldName=retweet_count|repeat_num
    var retweetCount: Int64 = -1
    
    // sourcery: jsonFieldName=favorite_count|fave_num
    var favoriteCount: Int64 = -1
    
    // sourcery: jsonFieldName=reply_count
    var replyCount: Int64 = -1
    
    // sourcery: jsonFieldName=favorited
    var favorited: Bool = false
    
    // sourcery: jsonFieldName=retweeted|repeated
    var retweeted: Bool = false
    
    // sourcery: jsonFieldName=lang
    var lang: String? = nil
    
    // sourcery: jsonFieldName=descendent_reply_count
    var descendentReplyCount: Int64 = -1
    
    // sourcery: jsonFieldName=retweeted_status
    var retweetedStatus: MicroBlogStatus? = nil
    
    /**
     * <code>repost_status</code> is for Fanfou, <code>quoted_status</code> is for twitter
     */
    // sourcery: jsonFieldName=quoted_status|repost_status
    var quotedStatus: MicroBlogStatus? = nil
    
    /**
     * <code>repost_status_id</code> is for Fanfou, <code>quoted_status_id_str</code> is for twitter
     */
    // sourcery: jsonFieldName=quoted_status_id_str|repost_status_id
    var quotedStatusId: String? = nil
    
    // sourcery: jsonFieldName=is_quote_status
    var isQuoteStatus: Bool = false
    
    // sourcery: jsonFieldName=card
    var card: TwitterCardEntity? = nil
    
    // sourcery: jsonFieldName=possibly_sensitive
    var possiblySensitive: Bool = false
    
    /**
     * For GNU social
     */
    // sourcery: jsonFieldName=attachments
    var attachments: [GNUSocialAttachment]? = nil
    
    /**
     * For GNU social
     */
    // sourcery: jsonFieldName=external_url
    var externalUrl: String? = nil
    
    // sourcery: jsonFieldName=statusnet_conversation_id
    var statusnetConversationId: String? = nil
    
    // sourcery: jsonFieldName=conversation_id|statusnet_conversation_id
    var conversationId: String? = nil
    
    
    /**
     * For GNU social
     */
    // sourcery: jsonFieldName=attentions
    var attentions: [GNUSocialAttention]? = nil
    
    /**
     * For Fanfou
     */
    // sourcery: jsonFieldName=photo
    var photo: FanfouPhoto? = nil
    /**
     * For Fanfou
     */
    // sourcery: jsonFieldName=location
    var location: String? = nil
    
    // sourcery: jsonFieldName=display_text_range
    var displayTextRange: [Int32]!
    
    /**
     * GNU social value
     * Format: {@code "tag:[gnusocial.host],YYYY-MM-DD:noticeId=[noticeId]:objectType=[objectType]"}
     */
    // sourcery: jsonFieldName=uri
    var uri: String? = nil
    
    // sourcery: jsonFieldName=timestamp_ms
    var timestampMs: Int64 = -1
    
    // sourcery: jsonFieldName=extended_tweet
    var extendedTweet: ExtendedTweet? = nil
    
    var sortId: Int64 {
        var result: Int64 = -1
        result = rawId;
        if (result == -1) {
            // Try use long id
            result = Int64(id) ?? -1
        }
        if (result == -1 && createdAt != nil) {
            // Try use timestamp
            result = createdAt.timeIntervalSince1970Millis
        }
        return result
    }
    
    var isRetweet: Bool {
        return retweetedStatus != nil
    }
    
    var fullEntities: TwitterEntities? {
        if let extended = self.extendedTweet {
            return extended.entities
        }
        return self.entities
    }
    
    var fullExtendedEntities: TwitterEntities? {
        if let extended = self.extendedTweet {
            return extended.extendedEntities
        }
        return self.extendedEntities
    }
    
    var htmlText: String! {
        if let html = statusnetHtml {
            return html
        }
        if let full = fullText {
            return full
        }
        return text
    }
    
    required init() {

    }
    
    // sourcery: jsonParse
    class ExtendedTweet {
        
        // sourcery: jsonFieldName=full_text
        var fullText: String!
        
        // sourcery: jsonFieldName=entities
        var entities: TwitterEntities? = nil
        
        // sourcery: jsonFieldName=extended_entities
        var extendedEntities: TwitterEntities? = nil
        
        // sourcery: jsonFieldName=display_text_range
        var displayTextRange: [Int32]!
        
        required init() {
            
        }
    }
    
    // sourcery: jsonParse
    class CurrentUserRetweet {
        // sourcery: jsonFieldName=id
        var id: String!
        
        required init() {
            
        }
    }
    
    
}
