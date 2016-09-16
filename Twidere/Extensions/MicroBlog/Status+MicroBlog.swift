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
    
    convenience init(status: JSON, accountKey: UserKey?) {
        self.init()
        self.accountKey = accountKey
        self.id = getTwitterEntityId(status)
        self.createdAt = parseTwitterDate(status["created_at"].stringValue)
        self.sortId = generateSortId(self, rawId: status["raw_id"].int64 ?? -1)
        
        var primary = status["retweeted_status"]
        if (primary.exists()) {
            self.retweetId = getTwitterEntityId(primary)
            
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
        self.userKey = User.getUserKey(user, accountHost: accountKey?.host)
        self.userName = user["name"].string
        self.userScreenName = user["screen_name"].string
        self.userProfileImage = getProfileImage(user)
        
        let (textPlain, textDisplay, metadata) = getMetadata(primary)
        
        self.textPlain = textPlain
        self.textDisplay = textDisplay
        self.metadata = metadata
        
        let quoted = primary["quoted_status"]
        if (quoted.exists()) {
            self.quotedId = getTwitterEntityId(quoted)
            
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
    
    static func arrayFromJson(_ json: JSON, accountKey: UserKey) -> [Status] {
        if let array = json.array {
            return array.map { item in return Status(status: item, accountKey: accountKey) }
        } else {
            return json["statuses"].map { (key, item) in return Status(status: item, accountKey: accountKey) }
        }
    }
    
    fileprivate func getProfileImage(_ user: JSON) -> String {
        return user["profile_image_url_https"].string ?? user["profile_image_url"].stringValue
    }
    
    fileprivate static let carets = CharacterSet(charactersIn: "<>")
    
    fileprivate func getMetadata(_ status: JSON) -> (plain: String, display: String, metadata: Status.Metadata) {
        let metadata = Status.Metadata()
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
            for entity in status["entities"]["urls"].arrayValue {
                spans.append(spanFromUrlEntity(entity))
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
            
            if let userMentions = status["entities"]["user_mentions"].array {
                for entity in userMentions {
                    spans.append(spanFromMentionEntity(entity))
                }
            }
            
            if let hashtags = status["entities"]["hashtags"].array {
                for entity in hashtags {
                    spans.append(spanFromHashtagEntity(entity))
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
                case is LinkSpanItem:
                    let typed = span as! LinkSpanItem
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
                case is MentionSpanItem:
                    let typed = span as! MentionSpanItem
                    
                    typed.start = codePoints.utf16Count(startIndex..<codePoints.index(codePoints.startIndex, offsetBy: offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    mentions.append(typed)
                case is HashtagSpanItem:
                    let typed = span as! HashtagSpanItem
                    
                    typed.start = codePoints.utf16Count(startIndex..<codePoints.index(codePoints.startIndex, offsetBy: offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    hashtags.append(typed)
                default: abort()
                }
                
            }
            
            let str = String(codePoints)
            textDisplay = str.decodeHTMLEntitiesWithOffset { (index, utf16Offset) in
                let intIndex = str.distance(from: str.startIndex, to: index)
                
                for span in spans where span.origStart >= intIndex {
                    span.start += utf16Offset
                    span.end += utf16Offset
                }
                if (displayTextRangeUtf16 != nil ) {
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
        return (textPlain, textDisplay, metadata)
    }
    
    fileprivate func mediaItemFromEntity(_ entity: JSON) -> MediaItem {
        let media = MediaItem()
        media.url = entity["media_url_https"].string ?? entity["media_url"].string
        media.mediaUrl = media.url
        media.previewUrl = media.url
        media.pageUrl = entity["expanded_url"].string
        media.type = getMediaType(entity["type"].string)
        media.altText = entity["alt_text"].string
        let size = entity["sizes"]["large"]
        if (size.exists()) {
            media.width = size["width"].intValue
            media.height = size["height"].intValue
        } else {
            media.width = 0;
            media.height = 0;
        }
        media.videoInfo = getVideoInfo(entity["video_info"]);
        return media
    }
    
    fileprivate func getMediaType(_ type: String?) -> MediaItem.MediaType {
        switch type {
        case "photo"?:
            return .Image
        case "video"?:
            return .Video
        case "animated_gif"?:
            return .AnimatedGif
        default: break
        }
        return .Unknown
    }
    
    fileprivate func getVideoInfo(_ json: JSON) -> MediaItem.VideoInfo {
        let info = MediaItem.VideoInfo()
        info.duration = json["duration"].int64Value
        info.variants = json["variants"].map { (k, v) -> MediaItem.VideoInfo.Variant in
            let variant = MediaItem.VideoInfo.Variant()
            variant.bitrate = v["bitrate"].int64Value
            variant.contentType = v["content_type"].string
            variant.url = v["url"].string
            return variant
        }
        return info
    }
    
    fileprivate func spanFromUrlEntity(_ entity: JSON) -> LinkSpanItem {
        let span = LinkSpanItem()
        span.display = entity["display_url"].stringValue
        span.link = entity["expanded_url"].stringValue
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
    }
    
    fileprivate func spanFromMentionEntity(_ entity: JSON) -> MentionSpanItem {
        let id = entity["id_str"].string ?? entity["id"].stringValue
        let span = MentionSpanItem()
        span.key = UserKey(id: id, host: nil)
        span.name = entity["name"].string
        span.screenName = entity["screen_name"].string
        
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
    }
    
    fileprivate func spanFromHashtagEntity(_ entity: JSON) -> HashtagSpanItem {
        let span = HashtagSpanItem()
        span.hashtag = entity["text"].stringValue
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
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
    
    fileprivate func generateSortId(_ status: Status, rawId: Int64) -> Int64 {
        var sortId = rawId;
        if (sortId == -1) {
            // Try use long id
            sortId = Int64(status.id) ?? -1
        }
        if (sortId == -1 && status.createdAt != nil) {
            // Try use timestamp
            sortId = createdAt!.timeIntervalSince1970Millis
        }
        return sortId;
    }
    
    fileprivate enum EntityType {
        case mention, url, hashtag
    }
}
