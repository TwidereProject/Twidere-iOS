//
//  MicroblogStatusExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

extension MicroBlogStatus {
  
    func toPersistable(details: AccountDetails, profileImageSize: String = "normal") -> PersistableStatus {
        return toParcelable(details.key, details.type, profileImageSize).apply {
            account_color = details.color
        }
    }
    
    func toPersistable(accountKey: UserKey, accountType: String, profileImageSize: String = "normal") -> PersistableStatus {
        let result = PersistableStatus()
        apply(to: result, accountKey: accountKey, accountType: accountType, profileImageSize: profileImageSize)
        return result
    }
    
    func apply(to result: PersistableStatus, accountKey: UserKey, accountType: String, profileImageSize: String = "normal") {
        let extras = PersistableStatus.Extras()
        result.account_key = accountKey
        result.id = id
        result.sort_id = sortId
        result.timestamp = createdAt?.timeIntervalSince1970Millis ?? 0
        
        extras.external_url = inferredExternalUrl
        extras.support_entities = entities != nil
        extras.statusnet_conversation_id = statusnetConversationId
        extras.conversation_id = conversationId
        result.is_pinned_status = self.user.pinnedTweetIds?.contains(id) ?? false
        
        
        result.is_retweet = isRetweet
        result.retweeted = retweeted
        let status: MicroBlogStatus
        if let retweetedStatus = self.retweetedStatus {
            status = retweetedStatus
            let retweetUser = self.user!
            result.retweet_id = status.id
            result.retweet_timestamp = status.createdAt?.timeIntervalSince1970Millis ?? 0
            result.retweeted_by_user_key = retweetUser.key
            result.retweeted_by_user_name = retweetUser.name
            result.retweeted_by_user_screen_name = retweetUser.screenName
            result.retweeted_by_user_profile_image = retweetUser.getProfileImage(ofSize: profileImageSize)
            
            extras.retweeted_external_url = retweetedStatus.inferredExternalUrl
            
            if (retweetUser.blocking ?? false) {
                result.addFilterFlag(.blockingUser)
            }
            if (retweetUser.blockedBy ?? false) {
                result.addFilterFlag(.blockedByUser)
            }
            if (status.possiblySensitive) {
                result.addFilterFlag(.possiblySensitive)
            }
        } else {
            status = self
            if (status.possiblySensitive) {
                result.addFilterFlag(.possiblySensitive)
            }
        }
        
        
        result.is_quote = status.isQuoteStatus
        result.quoted_id = status.quotedStatusId
        if let quoted = status.quotedStatus {
            let quotedUser = quoted.user!
            result.quoted_id = quoted.id
            extras.quoted_external_url = quoted.inferredExternalUrl
            
            let quotedText = quoted.htmlText!
            // Twitter will escape <> to &lt;&gt;, so if a status contains those symbols unescaped
            // We should treat this as an html
            if (quotedText.isHtml) {
                let html = HtmlSpanBuilder.fromHtml(quotedText, quoted.extendedText)
                result.quoted_text_unescaped = html?.toString()
                result.quoted_text_plain = result.quoted_text_unescaped
                result.quoted_spans = html?.spanItems
            } else {
                let textWithIndices = quoted.formattedTextWithIndices()
                result.quoted_text_plain = quotedText.twitterUnescaped()
                result.quoted_text_unescaped = textWithIndices.text
                result.quoted_spans = textWithIndices.spans
                extras.quoted_display_text_range = textWithIndices.range
            }
            
            result.quoted_timestamp = quoted.createdAt.timeIntervalSince1970Millis
            result.quoted_source = quoted.source
            //result.quoted_media = ParcelableMediaUtils.fromStatus(quoted, accountKey, accountType)
            
            result.quoted_user_key = quotedUser.key
            result.quoted_user_name = quotedUser.name
            result.quoted_user_screen_name = quotedUser.screenName
            result.quoted_user_profile_image = quotedUser.getProfileImage(ofSize: profileImageSize)
            result.quoted_user_is_protected = quotedUser.isProtected
            result.quoted_user_is_verified = quotedUser.isVerified
            
            if (quoted.possiblySensitive) {
                result.addFilterFlag(.possiblySensitive)
            }
        } else if (status.isQuoteStatus) {
            result.addFilterFlag(.quoteNotAvailable)
        }
        
        result.reply_count = status.replyCount
        result.retweet_count = status.retweetCount
        result.favorite_count = status.favoriteCount
        
        result.in_reply_to_name = status.inReplyToName
        result.in_reply_to_screen_name = status.inReplyToScreenName
        result.in_reply_to_status_id = status.inReplyToStatusId
        result.in_reply_to_user_key = status.getInReplyToUserKey(accountKey)
        
        let user = status.user!
        result.user_key = user.key
        result.user_name = user.name
        result.user_screen_name = user.screenName
        result.user_profile_image_url = user.getProfileImage(ofSize: profileImageSize)
        result.user_is_protected = user.isProtected
        result.user_is_verified = user.isVerified
        result.user_is_following = user.following ?? false
        extras.user_statusnet_profile_url = user.statusnetProfileUrl
        extras.user_profile_image_url_fallback = user.profileImageUrlHttps ?? user.profileImageUrl
        let text = status.htmlText!
        // Twitter will escape <> to &lt;&gt;, so if a status contains those symbols unescaped
        // We should treat this as an html
        if (text.isHtml) {
            let html = HtmlSpanBuilder.fromHtml(text, status.extendedText)
            result.text_unescaped = html?.toString()
            result.text_plain = result.text_unescaped
            result.spans = html?.spanItems
        } else {
            let textWithIndices = status.formattedTextWithIndices()
            result.text_unescaped = textWithIndices.text
            result.text_plain = text.twitterUnescaped()
            result.spans = textWithIndices.spans
            extras.display_text_range = textWithIndices.range
        }
        
        //result.media = ParcelableMediaUtils.fromStatus(status, accountKey, accountType)
        result.source = status.source
        result.location = status.geo?.geoLocation
        result.is_favorite = status.favorited
        if (result.account_key == result.retweeted_by_user_key) {
            result.my_retweet_id = result.id
        } else {
            result.my_retweet_id = status.currentUserRetweet?.id
        }
        result.is_possibly_sensitive = status.possiblySensitive
        result.mentions = status.fullEntities?.mentions?.map { $0.toPersistable(user.host) }
        result.card = status.card?.toPersistable(accountKey: accountKey, accountType: accountType)
        result.card_name = result.card?.name
        result.place_full_name = status.placeFullName
        result.lang = status.lang
        result.extras = extras
    }
    
    func formattedTextWithIndices() -> StatusTextWithIndices {
        let source = (self.fullText ?? self.text!).unicodeScalars
        // Display text range
        let builder = HtmlBuilder(source, throwExceptions: false, sourceIsEscaped: true, shouldReEscape: false)
        builder.addEntities(self)
        let textWithIndices = StatusTextWithIndices()
        let (text, spans) = builder.buildWithIndices()
        textWithIndices.text = text
        textWithIndices.spans = spans
        if let range = self.displayTextRange, range.count == 2 {
            textWithIndices.range = [
                getResultRangeLength(source, spans, 0, range[0]),
                text.length - getResultRangeLength(source, spans, range[1], source.length())
            ]
        }
        return textWithIndices
    }
    
    private var inReplyToName: String! {
        if let matched = fullEntities?.mentions?.first(where:  { inReplyToUserId == $0.id }) {
            return matched.name
        }
        if let matched =  attentions?.first(where: { inReplyToUserId == $0.id }) {
            return matched.fullName
        }
        return inReplyToScreenName
    }
    
    
    private var placeFullName: String! {
        if let fullName = place?.fullName {
            return fullName
        }
        //TODO return nil on coordinates
        return self.location
    }
    
    private var inferredExternalUrl: String! {
        guard let uri = self.externalUrl ?? self.uri else {
            return nil
        }
        return uri.replacingOccurrences(of: MicroBlogStatus.noticeUriRegex, with: "https://${result.groups[1]?.value}/notice/${result.groups[3]?.value}", options: .regularExpression)
    }
    
    private func getInReplyToUserKey(_ accountKey: UserKey) -> UserKey? {
        guard let inReplyToUserId = self.inReplyToUserId else {
            return nil
        }
        
        if let entities = self.fullEntities?.mentions {
            if (entities.contains(where: { inReplyToUserId == $0.id })) {
                return UserKey(id: inReplyToUserId, host: accountKey.host)
            }
        }
        
        if let attentions = self.attentions {
            if let matched = attentions.first(where: { inReplyToUserId == $0.id }) {
                let host = MicroBlogUser.getUserHost(matched.ostatusUri, def: accountKey.host)
                return UserKey(id: inReplyToUserId, host: host)
            }
        }
        return UserKey(id: inReplyToUserId, host: accountKey.host)
    }
    
    private static let noticeUriRegex = "tag:([\\w\\d.]+),(\\d{4}-\\d{2}-\\d{2}):noticeId=(\\d+):objectType=(\\w+)"
    
    class StatusTextWithIndices {
        var text: String? = nil
        var spans: [SpanItem]? = nil
        var range: [Int32]? = nil
    }
}

fileprivate extension HtmlBuilder {
    func addEntities(_ entities: TwitterEntitySupport) {
        // TODO: real implementation
    }
}

fileprivate extension String {
    var isHtml: Bool {
        return contains("<") && contains(">")
    }
    
    func twitterUnescaped() -> String {
        // TODO: decode twitter specific only
        return decodeHTMLEntitiesWithOffset()
    }
}
