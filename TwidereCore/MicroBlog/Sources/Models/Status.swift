// sourcery: jsonParse,jsonSerialize
public class Status: EntitySupport {

    // sourcery: jsonField=created_at
    // sourcery: jsonFieldConverter=TwitterDateFieldConverter
    public var createdAt: Date!

    // sourcery: jsonField=id
    public var id: String!
    
    // Fanfou uses this key
    // sourcery: jsonField=rawid
    public var rawId: Int64 = -1
    
    // sourcery: jsonField=text
    public var text: String!
    
    /**
     * https://dev.twitter.com/overview/api/upcoming-changes-to-tweets
     */
    // sourcery: jsonField=full_text
    public var fullText: String!
    
    // sourcery: jsonField=statusnet_html
    public var statusnetHtml: String!
    
    // sourcery: jsonField=source
    public var source: String? = nil
    
    // sourcery: jsonField=truncated
    public var truncated: Bool = false
    
    // sourcery: jsonField=entities
    public var entities: Entities? = nil
    
    // sourcery: jsonField=extended_entities
    public var extendedEntities: Entities? = nil
    
    // sourcery: jsonField=in_reply_to_status_id
    public var inReplyToStatusId: String?
    
    // sourcery: jsonField=in_reply_to_user_id
    public var inReplyToUserId: String?
    
    // sourcery: jsonField=in_reply_to_screen_name
    public var inReplyToScreenName: String?
    
    // sourcery: jsonField=user
    public var user: User! = nil
    
    // sourcery: jsonField=geo
    public var geo: GeoPoint? = nil
    
    // sourcery: jsonField=place
    public var place: Place? = nil
    
    // sourcery: jsonField=current_user_retweet
    public var currentUserRetweet: CurrentUserRetweet? = nil
    
    // sourcery: jsonField=retweet_count|repeat_num
    public var retweetCount: Int64 = -1
    
    // sourcery: jsonField=favorite_count|fave_num
    public var favoriteCount: Int64 = -1
    
    // sourcery: jsonField=reply_count
    public var replyCount: Int64 = -1
    
    // sourcery: jsonField=favorited
    public var favorited: Bool = false
    
    // sourcery: jsonField=retweeted|repeated
    public var retweeted: Bool = false
    
    // sourcery: jsonField=lang
    public var lang: String? = nil
    
    // sourcery: jsonField=descendent_reply_count
    public var descendentReplyCount: Int64 = -1
    
    // sourcery: jsonField=retweeted_status
    public var retweetedStatus: Status? = nil
    
    /**
     * <code>repost_status</code> is for Fanfou, <code>quoted_status</code> is for twitter
     */
    // sourcery: jsonField=quoted_status|repost_status
    public var quotedStatus: Status? = nil
    
    /**
     * <code>repost_status_id</code> is for Fanfou, <code>quoted_status_id_str</code> is for twitter
     */
    // sourcery: jsonField=quoted_status_id_str|repost_status_id
    public var quotedStatusId: String? = nil
    
    // sourcery: jsonField=is_quote_status
    public var isQuoteStatus: Bool = false
    
    // sourcery: jsonField=card
    public var card: CardEntity? = nil
    
    // sourcery: jsonField=possibly_sensitive
    public var possiblySensitive: Bool = false
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=attachments
    public var attachments: [Attachment]? = nil
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=external_url
    public var externalUrl: String? = nil
    
    // sourcery: jsonField=statusnet_conversation_id
    public var statusnetConversationId: String? = nil
    
    // sourcery: jsonField=conversation_id|statusnet_conversation_id
    public var conversationId: String? = nil
    
    
    /**
     * For GNU social
     */
    // sourcery: jsonField=attentions
    public var attentions: [Attention]? = nil
    
    /**
     * For Fanfou
     */
    // sourcery: jsonField=photo
    public var photo: Photo? = nil
    /**
     * For Fanfou
     */
    // sourcery: jsonField=location
    public var location: String? = nil
    
    // sourcery: jsonField=display_text_range
    public var displayTextRange: [Int]!
    
    /**
     * GNU social value
     * Format: {@code "tag:[gnusocial.host],YYYY-MM-DD:noticeId=[noticeId]:objectType=[objectType]"}
     */
    // sourcery: jsonField=uri
    public var uri: String? = nil
    
    // sourcery: jsonField=timestamp_ms
    public var timestampMs: Int64 = -1
    
    // sourcery: jsonField=extended_tweet
    public var extendedTweet: ExtendedTweet? = nil
    
    public var sortId: Int64 {
        var result: Int64 = -1
        result = rawId;
        if (result == -1) {
            // Try use long id
            result = Int64(id) ?? -1
        }
        if (result == -1 && createdAt != nil) {
            // Try use timestamp
            result = Int64(createdAt.timeIntervalSince1970 * 1000)
        }
        return result
    }
    
    public var isRetweet: Bool {
        return retweetedStatus != nil
    }
    
    public var fullEntities: Entities? {
        if let extended = self.extendedTweet {
            return extended.entities
        }
        return self.entities
    }
    
    public var fullExtendedEntities: Entities? {
        if let extended = self.extendedTweet {
            return extended.extendedEntities
        }
        return self.extendedEntities
    }
    
    public var htmlText: String! {
        if let html = statusnetHtml {
            return html
        }
        if let full = fullText {
            return full
        }
        return text
    }
    
    required public init() {

    }
    
    // sourcery: jsonParse
    public class ExtendedTweet {
        
        // sourcery: jsonField=full_text
        public var fullText: String!
        
        // sourcery: jsonField=entities
        public var entities: Entities? = nil
        
        // sourcery: jsonField=extended_entities
        public var extendedEntities: Entities? = nil
        
        // sourcery: jsonField=display_text_range
        public var displayTextRange: [Int]!
        
        required public init() {
            
        }
    }
    
    // sourcery: jsonParse
    public class CurrentUserRetweet {
        // sourcery: jsonField=id
        public var id: String!
        
        required public init() {
            
        }
    }
    
    
}
