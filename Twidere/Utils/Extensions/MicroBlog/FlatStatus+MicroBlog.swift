//
//  FlatStatus+JSON.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON
import StringExtensionHTML

extension FlatStatus {
    
    convenience init(status: JSON, account: Account) {
        self.init()
        self.accountKey = UserKey(rawValue: account.accountKey!)
        self.id = getTwitterEntityId(status)
        self.createdAt = parseTwitterDate(status["created_at"].stringValue)
        self.sortId = generateSortId(self, rawId: status["raw_id"].int64 ?? -1)
        
        var primary = status["retweeted_status"]
        if (primary.isExists()) {
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
        let userId = getTwitterEntityId(user)
        self.userKey = UserKey(id: userId, host: self.accountKey.host)
        self.userName = user["name"].string
        self.userScreenName = user["screen_name"].string
        self.userProfileImage = getProfileImage(user)
        
        let (textPlain, textDisplay, metadata) = getMetadata(primary)
        
        self.textPlain = textPlain
        self.textDisplay = textDisplay
        self.metadata = metadata
        
        let quoted = primary["quoted_status"]
        if (quoted.isExists()) {
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
    
    static func arrayFromJson(json: JSON, account: Account) -> [FlatStatus] {
        if let array = json.array {
            return array.map { item in return FlatStatus(status: item, account: account) }
        } else {
            return json["statuses"].map { (key, item) in return FlatStatus(status: item, account: account) }
        }
    }
    
    private func getProfileImage(user: JSON) -> String {
        return user["profile_image_url_https"].string ?? user["profile_image_url"].stringValue
    }
    
    private static let carets = NSCharacterSet(charactersInString: "<>")

    private func getMetadata(status: JSON) -> (String, String, Metadata) {
        let metadata = Metadata()
        var links = [LinkSpanItem]()
        var mentions = [MentionSpanItem]()
        var hashtags = [HashtagSpanItem]()
        var mediaItems = [MediaItem]()
        let textPlain: String
        let textDisplay: String
        if let statusNetHtml = status["statusnet_html"].string {
            textPlain = statusNetHtml.stringByDecodingHTMLEntities
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
            
            var indices = [Range<Int>]()
            
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
                if let insertIdx = indices.indexOf({ item -> Bool in return item.startIndex > range.startIndex }) {
                    indices.insert(range, at: insertIdx)
                } else {
                    indices.append(range)
                }
                return true
            }
            
            // Order entities
            spans.sortInPlace { (l, r) -> Bool in
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
                    codePoints.utf16Count(codePoints.startIndex..<codePoints.startIndex.advancedBy(displayStart)),
                    codePoints.utf16Count(codePoints.startIndex..<codePoints.startIndex.advancedBy(displayEnd))
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
                    
                    let subRange = startIndex.advancedBy(offsetedStart)..<startIndex.advancedBy(offsetedEnd)
                    
                    let subRangeUtf16Length = codePoints.utf16Count(subRange)
                    
                    codePoints.replaceRange(subRange, with: displayUrlCodePoints)
                    
                    startIndex = codePoints.startIndex
                    
                    typed.start = codePoints.utf16Count(startIndex..<startIndex.advancedBy(offsetedStart))
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
                    
                    typed.start = codePoints.utf16Count(startIndex..<startIndex.advancedBy(offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    mentions.append(typed)
                case is HashtagSpanItem:
                    let typed = span as! HashtagSpanItem
                    
                    typed.start = codePoints.utf16Count(startIndex..<startIndex.advancedBy(offsetedStart))
                    typed.end = typed.start + origEnd - origStart
                    hashtags.append(typed)
                default: abort()
                }
                
            }
            
            let str = String(codePoints)
            textDisplay = str.decodeHTMLEntitiesWithOffset { (index, utf16Offset) in
                let intIndex = str.startIndex.distanceTo(index)
                
                for span in spans where span.origStart >= intIndex {
                    span.start += utf16Offset
                    span.end += utf16Offset
                }
                if (displayTextRangeUtf16?[0] >= intIndex) {
                    displayTextRangeUtf16?[0] += utf16Offset
                }
                if (displayTextRangeUtf16?[1] >= intIndex) {
                    displayTextRangeUtf16?[1] += utf16Offset
                }
            }
            textPlain = fullText.stringByDecodingHTMLEntities
            
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
    
    private func mediaItemFromEntity(entity: JSON) -> MediaItem {
        let media = MediaItem()
        media.url = entity["media_url_https"].string ?? entity["media_url"].string
        media.mediaUrl = media.url
        media.previewUrl = media.url
        media.pageUrl = entity["expanded_url"].string
        media.type = getMediaType(entity["type"].string)
        media.altText = entity["alt_text"].string
        let size = entity["sizes"]["large"]
        if (size.isExists()) {
            media.width = size["width"].intValue
            media.height = size["height"].intValue
        } else {
            media.width = 0;
            media.height = 0;
        }
        media.videoInfo = getVideoInfo(entity["video_info"]);
        return media
    }
    
    private func getMediaType(type: String?) -> MediaItem.MediaType {
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
    
    private func getVideoInfo(json: JSON) -> MediaItem.VideoInfo {
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
    
    private func spanFromUrlEntity(entity: JSON) -> LinkSpanItem {
        let span = LinkSpanItem(display: entity["display_url"].stringValue, link: entity["expanded_url"].stringValue)
        
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
    }
    
    private func spanFromMentionEntity(entity: JSON) -> MentionSpanItem {
        let id = entity["id_str"].string ?? entity["id"].stringValue
        let span = MentionSpanItem(key: UserKey(id: id, host: nil))
        span.name = entity["name"].string
        span.screenName = entity["screen_name"].string
        
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
    }
    
    private func spanFromHashtagEntity(entity: JSON) -> HashtagSpanItem {
        let span = HashtagSpanItem(hashtag: entity["text"].stringValue)
        
        span.origStart = entity["indices"][0].int ?? -1
        span.origEnd = entity["indices"][1].int ?? -1
        
        return span
    }
    
    private func calculateDisplayTextRange(status: JSON, source: String, display: String, spans:[SpanItem]) -> [Int]? {
        guard let start = status["display_text_range"][0].int, let end = status["display_text_range"][1].int else {
            return nil
        }
        let sourceCodePoints = source.unicodeScalars
        let rangeStart = getResultRangeLength(sourceCodePoints, spans: spans, origStart: 0, origEnd: start)
        let rangeEnd = display.utf16.count - getResultRangeLength(sourceCodePoints, spans: spans, origStart: end, origEnd: sourceCodePoints.count)
        return [rangeStart, rangeEnd]
    }
    
    private func getResultRangeLength(source: String.UnicodeScalarView, spans: [SpanItem], origStart: Int, origEnd: Int) -> Int {
        let findResult = findByOrigRange(spans, start: origStart, end: origEnd)
        let startIndex = source.startIndex
        if (findResult.isEmpty) {
            return source.utf16Count(startIndex.advancedBy(origStart)..<startIndex.advancedBy(origEnd))
        }
        guard let first = findResult.first, let last = findResult.last else {
            return 0
        }
        if (first.origStart == -1 || last.origEnd == -1){
            return source.utf16Count(source.startIndex.advancedBy(origStart)..<source.startIndex.advancedBy(origEnd))
        }
        return source.utf16Count(startIndex.advancedBy(origStart)..<startIndex.advancedBy(first.origStart)) + (last.end - first.start) + source.utf16Count(startIndex.advancedBy(first.origEnd)..<startIndex.advancedBy(origEnd))
    }
    
    private func findByOrigRange(spans: [SpanItem], start: Int, end:Int)-> [SpanItem] {
        var result = [SpanItem]()
        for span in spans {
            if (span.origStart >= start && span.origEnd <= end) {
                result.append(span)
            }
        }
        return result
    }
    
    private func hasClash(sortedIndices: [Range<Int>], range: Range<Int>) -> Bool {
        if (range.endIndex < sortedIndices.first?.startIndex) {
            return false
        }
        if (range.startIndex > sortedIndices.last?.endIndex) {
            return false
        }
        var i = 0
        while i < sortedIndices.endIndex - 1 {
            let end = sortedIndices[i].endIndex
            let start = sortedIndices[i + 1].startIndex
            if (range.startIndex > end && range.endIndex < start) {
                return false
            }
            i += 1
        }
        return true
    }
    
    private func generateSortId(status: FlatStatus, rawId: Int64) -> Int64 {
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
    
    private enum EntityType {
        case Mention, Url, Hashtag
    }
}