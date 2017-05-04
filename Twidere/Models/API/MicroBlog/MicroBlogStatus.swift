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

    // sourcery: jsonField=created_at
    // sourcery: jsonFieldConverter=TwitterDateFieldConverter
    var createdAt: Date!

    // sourcery: jsonField=id
    var id: String!
    
    // Fanfou uses this key
    // sourcery: jsonField=rawid
    var rawId: Int64 = -1
    
    // sourcery: jsonField=text
    var text: String!
    
    /**
     * https://dev.twitter.com/overview/api/upcoming-changes-to-tweets
     */
    // sourcery: jsonField=full_text
    var fullText: String!
    
    // sourcery: jsonField=statusnet_html
    var statusnetHtml: String!
    
    // sourcery: jsonField=source
    var source: String? = nil
    
    // sourcery: jsonField=truncated
    var truncated: Bool = false
    
    // sourcery: jsonField=entities
    var entities: TwitterEntities? = nil
    
    // sourcery: jsonField=extended_entities
    var extendedEntities: TwitterEntities? = nil
    
    // sourcery: jsonField=in_reply_to_status_id
    var inReplyToStatusId: String?
    
    // sourcery: jsonField=in_reply_to_user_id
    var inReplyToUserId: String?
    
    // sourcery: jsonField=in_reply_to_screen_name
    var inReplyToScreenName: String?
    
    // sourcery: jsonField=user
    var user: MicroBlogUser! = nil
    
    // sourcery: jsonField=geo
    var geo: MicroBlogGeoPoint? = nil
    
    // sourcery: jsonField=place
    var place: MicroBlogPlace? = nil
    
    // sourcery: jsonField=current_user_retweet
    var currentUserRetweet: CurrentUserRetweet? = nil
    
    // sourcery: jsonField=retweet_count|repeat_num
    var retweetCount: Int64 = -1
    
    // sourcery: jsonField=favorite_count|fave_num
    var favoriteCount: Int64 = -1
    
    // sourcery: jsonField=reply_count
    var replyCount: Int64 = -1
    
    // sourcery: jsonField=favorited
    var favorited: Bool = false
    
    // sourcery: jsonField=retweeted|repeated
    var retweeted: Bool = false
    
    // sourcery: jsonField=lang
    var lang: String? = nil
    
    // sourcery: jsonField=descendent_reply_count
    var descendentReplyCount: Int64 = -1
    
    // sourcery: jsonField=retweeted_status
    var retweetedStatus: MicroBlogStatus? = nil
    
    /**
     * <code>repost_status</code> is for Fanfou, <code>quoted_status</code> is for twitter
     */
    // sourcery: jsonField=quoted_status|repost_status
    var quotedStatus: MicroBlogStatus? = nil
    
    /**
     * <code>repost_status_id</code> is for Fanfou, <code>quoted_status_id_str</code> is for twitter
     */
    // sourcery: jsonField=quoted_status_id_str|repost_status_id
    var quotedStatusId: String? = nil
    
    // sourcery: jsonField=is_quote_status
    var isQuoteStatus: Bool = false
    
    // sourcery: jsonField=card
    var card: TwitterCardEntity? = nil
    
    // sourcery: jsonField=possibly_sensitive
    var possiblySensitive: Bool = false
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=attachments
    var attachments: [GNUSocialAttachment]? = nil
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=external_url
    var externalUrl: String? = nil
    
    // sourcery: jsonField=statusnet_conversation_id
    var statusnetConversationId: String? = nil
    
    // sourcery: jsonField=conversation_id|statusnet_conversation_id
    var conversationId: String? = nil
    
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=attentions
    var attentions: [GNUSocialAttention]? = nil
    
    /**
     * For Fanfou
     */
    // sourcery: jsonField=photo
    var photo: FanfouPhoto? = nil
    /**
     * For Fanfou
     */
    // sourcery: jsonField=location
    var location: String? = nil
    
    // sourcery: jsonField=display_text_range
    var displayTextRange: [Int]!
    
    /**
     * GNU social value
     * Format: {@code "tag:[gnusocial.host],YYYY-MM-DD:noticeId=[noticeId]:objectType=[objectType]"}
     */
    // sourcery: jsonField=uri
    var uri: String? = nil
    
    // sourcery: jsonField=timestamp_ms
    var timestampMs: Int64 = -1
    
    // sourcery: jsonField=extended_tweet
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
        
        // sourcery: jsonField=full_text
        var fullText: String!
        
        // sourcery: jsonField=entities
        var entities: TwitterEntities? = nil
        
        // sourcery: jsonField=extended_entities
        var extendedEntities: TwitterEntities? = nil
        
        // sourcery: jsonField=display_text_range
        var displayTextRange: [Int]!
        
        required init() {
            
        }
    }
    
    // sourcery: jsonParse
    class CurrentUserRetweet {
        // sourcery: jsonField=id
        var id: String!
        
        required init() {
            
        }
    }
    
    
}
