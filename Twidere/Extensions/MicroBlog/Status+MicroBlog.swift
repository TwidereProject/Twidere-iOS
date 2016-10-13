//
//  Status+JSON.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l <= r
    default:
        return !(rhs < lhs)
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


extension Status {
    
    init?(status: JSON, accountKey: UserKey?) {
        self.accountKey = accountKey
        self.id = getTwitterEntityId(status)
        self.createdAt = parseTwitterDate(status["created_at"].stringValue)!
        self.sortId = generateSortId(rawId: status["raw_id"].int64 ?? -1)
        
        var primary = status["retweeted_status"]
        if (primary.exists()) {
            self.retweetId = getTwitterEntityId(primary)
            self.retweetCreatedAt = parseTwitterDate(primary["created_at"].stringValue)
            
            let retweetedBy = status["user"]
            let userId = getTwitterEntityId(retweetedBy)
            self.retweetedByUserKey = UserKey(id: userId, host: self.accountKey.host)
            self.retweetedByUserName = retweetedBy["name"].string
            self.retweetedByUserScreenName = retweetedBy["screen_name"].string
            self.retweetedByUserProfileImage = getProfileImage(retweetedBy)
        } else {
            primary = status
        }
        
        let user = primary["user"]
        guard let userKey = User.getUserKey(user, accountHost: accountKey?.host) else {
            return nil
        }
        self.userKey = userKey
        self.userName = user["name"].stringValue
        self.userScreenName = user["screen_name"].stringValue
        self.userProfileImage = getProfileImage(user)
        
        var (textPlain, textDisplay, metadata) = getMetadata(primary)
        
        metadata.replyCount = status["reply_count"].int64
        metadata.retweetCount = status["retweet_count"].int64
        metadata.favoriteCount = status["favorite_count"].int64
        
        self.textPlain = textPlain
        self.textDisplay = textDisplay
        self.metadata = metadata
        
        let quoted = primary["quoted_status"]
        if (quoted.exists()) {
            self.quotedId = getTwitterEntityId(quoted)
            self.quotedCreatedAt = parseTwitterDate(quoted["created_at"].stringValue)
            
            let quotedUser = quoted["user"]
            let quotedUserId = getTwitterEntityId(quotedUser)
            self.quotedUserKey = UserKey(id: quotedUserId, host: self.accountKey.host)
            self.quotedUserName = quotedUser["name"].string
            self.quotedUserScreenName = quotedUser["screen_name"].string
            self.quotedUserProfileImage = getProfileImage(quotedUser)
            
            let (quotedTextPlain, quotedTextDisplay, quotedMetadata) = getMetadata(quoted)
            self.quotedTextPlain = quotedTextPlain
            self.quotedTextDisplay = quotedTextDisplay
            self.quotedMetadata = quotedMetadata
        }
        
    }
    
    static func arrayFromJson(_ json: JSON, accountKey: UserKey?) -> [Status] {
        if let array = json.array {
            return array.map { Status(status: $0, accountKey: accountKey)! }
        } else {
            return json["statuses"].map { Status(status: $1, accountKey: accountKey)! }
        }
    }
    
    fileprivate func getProfileImage(_ user: JSON) -> String {
        return user["profile_image_url_https"].string ?? user["profile_image_url"].stringValue
    }
    
    fileprivate static let carets = CharacterSet(charactersIn: "<>")
    
    fileprivate func getMetadata(_ status: JSON) -> (plain: String, display: String, metadata: Status.Metadata) {
        var metadata = Status.Metadata()
        var links = [LinkSpanItem]()
        var mentions = [MentionSpanItem]()
        var hashtags = [HashtagSpanItem]()
        var mediaItems = [MediaItem]()
        let textPlain: String
        let textDisplay: String
        if let statusNetHtml = status["statusnet_html"].string {
            textPlain = statusNetHtml.decodeHTMLEntitiesWithOffset()
            textDisplay = textPlain
        } else if let fullText = status["full_text"].string ?? status["text"].string {
            var spans = [SpanItem]()
            if let urls = status["entities"]["urls"].array {
                for entity in urls {
                    spans.append(spanFromUrlEntity(entity))
                }
            }
            
            if let userMentions = status["entities"]["user_mentions"].array {
                for entity in userMentions {
                    spans.append(spanFromMentionEntity(entity, accountKey: accountKey))
                }
            }
            
            if let hashtags = status["entities"]["hashtags"].array {
                for entity in hashtags {
                    spans.append(spanFromHashtagEntity(entity))
                }
            }
            
            if let extendedMedia = status["extended_entities"]["media"].array {
                for entity in extendedMedia {
                    spans.append(spanFromUrlEntity(entity))
                    mediaItems.append(mediaItemFromEntity(entity))
                }
            } else if let media = status["entities"]["media"].array {
                for entity in media {
                    spans.append(spanFromUrlEntity(entity))
                    mediaItems.append(mediaItemFromEntity(entity))
                }
            }
            
            var indices = [CountableRange<Int>]()
            
            // Remove duplicate entities
            spans = spans.filter { entity -> Bool in
                if (entity.origStart < 0 || entity.origEnd < 0) {
                    return false
                }
                let range = entity.origStart..<entity.origEnd
                if (hasClash(indices, range: range)) {
                    return false
                }
                //
                if let insertIdx = indices.index(where: { item -> Bool in return item.lowerBound > range.lowerBound }) {
                    indices.insert(range, at: insertIdx)
                } else {
                    indices.append(range)
                }
                return true
            }
            
            // Order entities
            spans.sort { (l, r) -> Bool in
                return l.origStart < r.origEnd
            }
            
            var codePointOffset = 0
            var codePoints = fullText.unicodeScalars
            
            // Display text range in utf16
            var displayTextRangeCodePoint: [Int]? = nil
            var displayTextRangeUtf16: [Int]? = nil
            
            if let displayStart = status["display_text_range"][0].int, let displayEnd = status["display_text_range"][1].int {
                displayTextRangeCodePoint = [displayStart, displayEnd]
                displayTextRangeUtf16 = [
                    codePoints.utf16Count(codePoints.startIndex..<codePoints.index(codePoints.startIndex, offsetBy: displayStart)),
                    codePoints.utf16Count(codePoints.startIndex..<codePoints.index(codePoints.startIndex, offsetBy: displayEnd))
                ]
            }
            
            for span in spans {
                let origStart = span.origStart, origEnd = span.origEnd
                
                let offsetedStart = origStart + codePointOffset
                let offsetedEnd = origEnd + codePointOffset
                
                var startIndex = codePoints.startIndex
                
                switch span {
                case var typed as LinkSpanItem:
                    let displayUrlCodePoints = typed.display!.unicodeScalars
                    let displayCodePointsLength = displayUrlCodePoints.count
                    let displayUtf16Length = typed.display!.utf16.count
                    
                    let subRange = codePoints.index(codePoints.startIndex, offsetBy: offsetedStart)..<codePoints.index(codePoints.startIndex, offsetBy: offsetedEnd)
                    
                    let subRangeUtf16Length = codePoints.utf16Count(subRange)
                    
                    codePoints.replaceSubrange(subRange, with: displayUrlCodePoints)
                    
                    startIndex = codePoints.startIndex
                    
                    typed.start = codePoints.utf16Count(startIndex..<codePoints.index(codePoints.startIndex, offsetBy: offsetedStart))
                    typed.end = typed.start + displayUtf16Length
                    links.append(typed)
                    
                    let codePointDiff = displayCodePointsLength - (origEnd - origStart)
                    let utf16Diff = displayUtf16Length - subRangeUtf16Length
                    codePointOffset += codePointDiff
                    if (typed.origEnd < displayTextRangeCodePoint?[0]) {
                        displayTextRangeUtf16?[0] += utf16Diff
                    }
                    if (typed.origEnd <= displayTextRangeCodePoint?[1]) {
                        displayTextRangeUtf16?[1] += utf16Diff
                    }
                case var typed as MentionSpanItem:
                    typed.start = codePoints.utf16Count(startIndex..<codePoints.index(codePoints.startIndex, offsetBy: offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    mentions.append(typed)
                case var typed as HashtagSpanItem:
                    typed.start = codePoints.utf16Count(startIndex..<codePoints.index(codePoints.startIndex, offsetBy: offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    hashtags.append(typed)
                default: abort()
                }
                
            }
            
            let str = String(codePoints)
            textDisplay = str.decodeHTMLEntitiesWithOffset { (index, utf16Offset) in
                let intIndex = str.distance(from: str.startIndex, to: index)
                
                for i in 0..<spans.count {
                    var span = spans[i]
                    if (span.origStart < intIndex) {
                        continue
                    }
                    span.start += utf16Offset
                    span.end += utf16Offset
                    spans[i] = span
                }
                if (displayTextRangeUtf16 != nil) {
                    if (displayTextRangeUtf16![0] >= intIndex) {
                        displayTextRangeUtf16![0] += utf16Offset
                    }
                    if (displayTextRangeUtf16![1] >= intIndex) {
                        displayTextRangeUtf16![1] += utf16Offset
                    }
                }
            }
            textPlain = fullText.decodeHTMLEntitiesWithOffset()
            
            metadata.displayRange = displayTextRangeUtf16
        } else {
            textPlain = status["text"].stringValue
            textDisplay = textPlain
        }
        metadata.links = links
        metadata.mentions = mentions
        metadata.hashtags = hashtags
        metadata.media = mediaItems
        
        if var inReplyTo = Status.Metadata.InReplyTo(status: status, accountKey: accountKey) {
            inReplyTo.userName = mentions.filter { $0.key?.id == inReplyTo.userKey.id }.first?.name
            metadata.inReplyTo = inReplyTo
        } else {
            metadata.inReplyTo = nil
        }
        
        metadata.externalUrl = status["external_url"].string
        
        return (textPlain, textDisplay, metadata)
    }
    
    fileprivate func mediaItemFromEntity(_ entity: JSON) -> MediaItem {
        let url = entity["media_url_https"].string ?? entity["media_url"].stringValue
        let pageUrl = entity["expanded_url"].string
        let type = getMediaType(entity["type"].string)
        let altText = entity["alt_text"].string
        let size = entity["sizes"]["large"]
        let width: Int
        let height: Int
        if (size.exists()) {
            width = size["w"].intValue
            height = size["h"].intValue
        } else {
            width = 0
            height = 0
        }
        let videoInfo = getVideoInfo(entity["video_info"])
        return MediaItem(url: url, mediaUrl: url, previewUrl: url, type: type, width: width, height: height, videoInfo: videoInfo, pageUrl: pageUrl, openBrowser: false, altText: altText)
    }
    
    fileprivate func getMediaType(_ type: String?) -> MediaItem.MediaType {
        switch type {
        case "photo"?:
            return .image
        case "video"?:
            return .video
        case "animated_gif"?:
            return .animatedGif
        default: break
        }
        return .unknown
    }
    
    fileprivate func getVideoInfo(_ json: JSON) -> MediaItem.VideoInfo {
        let duration = json["duration"].int64Value
        let variants = json["variants"].flatMap { (k, v) -> MediaItem.VideoInfo.Variant? in
            guard let url = v["url"].string, let contentType = v["content_type"].string else {
                return nil
            }
            let bitrate = v["bitrate"].int64Value
            return MediaItem.VideoInfo.Variant(url: url, contentType: contentType, bitrate: bitrate)
        }
        return MediaItem.VideoInfo(duration: duration, variants: variants)
    }
    
    fileprivate func spanFromUrlEntity(_ entity: JSON) -> LinkSpanItem {
        let display = entity["display_url"].string
        let link = entity["expanded_url"].stringValue
        let origStart = entity["indices"][0].int ?? -1
        let origEnd = entity["indices"][1].int ?? -1
        
        return LinkSpanItem(start: -1, end: -1, origStart: origStart, origEnd: origEnd, link: link, display: display)
    }
    
    fileprivate func spanFromMentionEntity(_ entity: JSON, accountKey: UserKey?) -> MentionSpanItem {
        let id = entity["id_str"].string ?? entity["id"].stringValue
        let key = UserKey(id: id, host: accountKey?.host)
        let name = entity["name"].stringValue
        let screenName = entity["screen_name"].stringValue
        
        let origStart = entity["indices"][0].int ?? -1
        let origEnd = entity["indices"][1].int ?? -1
        
        return MentionSpanItem(start: -1, end: -1, origStart: origStart, origEnd: origEnd, key: key, name: name, screenName: screenName)
    }
    
    fileprivate func spanFromHashtagEntity(_ entity: JSON) -> HashtagSpanItem {
        let origStart = entity["indices"][0].int ?? -1
        let origEnd = entity["indices"][1].int ?? -1
        let hashtag = entity["text"].stringValue
        
        return HashtagSpanItem(start: -1, end: -1, origStart: origStart, origEnd: origEnd, hashtag: hashtag)
    }
    
    fileprivate func findByOrigRange(_ spans: [SpanItem], start: Int, end:Int)-> [SpanItem] {
        var result = [SpanItem]()
        for span in spans {
            if (span.origStart >= start && span.origEnd <= end) {
                result.append(span)
            }
        }
        return result
    }
    
    fileprivate func hasClash(_ sortedIndices: [CountableRange<Int>], range: CountableRange<Int>) -> Bool {
        if (range.upperBound < sortedIndices.first?.lowerBound) {
            return false
        }
        if (range.lowerBound > sortedIndices.last?.upperBound) {
            return false
        }
        var i = 0
        while i < sortedIndices.endIndex - 1 {
            let end = sortedIndices[i].upperBound
            let start = sortedIndices[i + 1].lowerBound
            if (range.lowerBound > end && range.upperBound < start) {
                return false
            }
            i += 1
        }
        return true
    }
    
    internal func generateSortId(rawId: Int64) -> Int64 {
        var sortId = rawId
        if (sortId == -1) {
            // Try use long id
            sortId = Int64(self.id) ?? -1
        }
        if (sortId == -1) {
            // Try use timestamp
            sortId = self.createdAt.timeIntervalSince1970Millis
        }
        return sortId
    }
    
    fileprivate enum EntityType {
        case mention, url, hashtag
    }
    
    class Spans {
        
        var links: [LinkSpanItem]?
        var mentions: [MentionSpanItem]?
        var hashtags: [HashtagSpanItem]?
    }
}

extension Status.Metadata.InReplyTo {
    init?(status: JSON, accountKey: UserKey?) {
        let statusId = status["in_reply_to_status_id"].stringValue
        let userId = status["in_reply_to_user_id"].stringValue
        if statusId.isEmpty || userId.isEmpty {
            return nil
        }
        self.statusId = statusId
        self.userKey = UserKey(id: userId, host: accountKey?.host)
        self.userScreenName = status["in_reply_to_screen_name"].stringValue
        
    }
}
