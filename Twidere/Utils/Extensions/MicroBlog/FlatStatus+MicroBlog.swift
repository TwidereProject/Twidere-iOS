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
            
            let user = primary["user"]
            let userId = getTwitterEntityId(user)
            self.retweetedByUserKey = UserKey(id: userId, host: self.accountKey.host)
            self.retweetedByUserName = user["name"].string
            self.retweetedByUserScreenName = user["screen_name"].string
            self.retweetedByUserProfileImage = getProfileImage(user)
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
    
    private func getStatusText(status: JSON) -> String {
        let htmlText = status["statusnet_html"].string ?? status["text"].stringValue
        // Twitter will escape <> to &lt;&gt;, so if a status contains those symbols unescaped
        // We should treat this as an html
        if (htmlText.rangeOfCharacterFromSet(FlatStatus.carets) != nil) {
            return htmlText.stringByDecodingHTMLEntities
        }
        let text = status["full_text"].string ?? status["text"].stringValue
        return text.stringByDecodingHTMLEntities
    }
    
    private func getMetadata(status: JSON) -> (String, String, Metadata) {
        let metadata = Metadata()
        var spans = [LinkSpanItem]()
        var mentions = [MentionSpanItem]()
        var hashtags = [HashtagSpanItem]()
        let text = getStatusText(status)
        var codePoints = text.unicodeScalars
        
        var codePointOffset = 0
        
        var entities = [(JSON, EntityType)]()
        for entity in status["entities"]["urls"].arrayValue {
            entities.append((entity, .Url))
        }
        if let extendedMedia = status["extended_entities"]["media"].array {
            for entity in extendedMedia {
                entities.append((entity, .Url))
            }
        } else if let media = status["entities"]["media"].array {
            for entity in media {
                entities.append((entity, .Url))
            }
        }
        
        if let userMentions = status["entities"]["user_mentions"].array {
            for entity in userMentions {
                entities.append((entity, .Mention))
            }
        }
        
        if let hashtags = status["entities"]["hashtags"].array {
            for entity in hashtags {
                entities.append((entity, .Hashtag))
            }
        }
        
        var indices = [Range<Int>]()
        
        // Remove duplicate entities
        entities = entities.filter { (entity, _) -> Bool in
            guard let start = entity["indices"][0].int, let end = entity["indices"][1].int else {
                return false
            }
            let range = start..<end
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
        entities.sortInPlace { (l, r) -> Bool in
            return l.0["indices"][0].intValue < r.0["indices"][0].intValue
        }
        
        for (entity, type) in entities {
            guard let start = entity["indices"][0].int, let end = entity["indices"][1].int else {
                continue
            }
            
            let rangeStart = codePointOffset + start
            let rangeEnd = codePointOffset + end
            
            var startIndex = codePoints.startIndex
            
            switch type {
            case .Url:
                if let expandedUrl = entity["expanded_url"].string, let displayUrl = entity["display_url"].string {
                    let displayUrlCodePoints = displayUrl.unicodeScalars
                    let displayLength = displayUrlCodePoints.count
                    
                    codePoints.replaceRange(startIndex.advancedBy(rangeStart)..<startIndex.advancedBy(rangeEnd), with: displayUrlCodePoints)
                    
                    startIndex = codePoints.startIndex
                    
                    let spanStart = codePoints.utf16Count(startIndex..<startIndex.advancedBy(rangeStart))
                    let spanEnd = spanStart + displayUrl.utf16.count
                    let span = LinkSpanItem(start: spanStart, end: spanEnd, link: expandedUrl)
                    span.origStart = start
                    span.origEnd = end
                    spans.append(span)
                    codePointOffset += displayLength - (end - start)
                }
            case .Mention:
                let id = entity["id_str"].string ?? entity["id"].stringValue
                if (!id.isEmpty) {
                    let userStart = codePoints.utf16Count(startIndex..<startIndex.advancedBy(rangeStart))
                    let userEnd = userStart + end - start
                    let mention = MentionSpanItem(start: userStart, end: userEnd, key: UserKey(id: id, host: nil))
                    mention.name = entity["name"].string
                    mention.screenName = entity["screen_name"].string
                    mentions.append(mention)
                }
            case .Hashtag:
                if let hashtagString = entity["text"].string {
                    let userStart = codePoints.utf16Count(startIndex..<startIndex.advancedBy(rangeStart))
                    let userEnd = userStart + end - start
                    hashtags.append(HashtagSpanItem(start: userStart, end: userEnd, hashtag: hashtagString))
                }
            }
            
        }
        metadata.spans = spans
        metadata.mentions = mentions
        metadata.hashtags = hashtags
        metadata.displayRange = calculateDisplayTextRange(status, source: text, display: codePoints, spans: spans)
        return (text, String(codePoints), metadata)
    }
    
    private func calculateDisplayTextRange(status: JSON, source: String, display: String.UnicodeScalarView, spans:[LinkSpanItem]) -> [Int]? {
        guard let start = status["display_text_range"][0].int, let end = status["display_text_range"][1].int else {
            return nil
        }
        let sourceCodePoints = source.unicodeScalars
        return [
            getResultRangeLength(sourceCodePoints, spans: spans, origStart: 0, origEnd: start),
            display.utf16Count() - getResultRangeLength(sourceCodePoints, spans: spans, origStart: end, origEnd: sourceCodePoints.count)
        ]
    }
    
    private func getResultRangeLength(source: String.UnicodeScalarView, spans: [LinkSpanItem], origStart: Int, origEnd: Int) -> Int {
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
    
    private func findByOrigRange(spans: [LinkSpanItem], start: Int, end:Int)-> [LinkSpanItem] {
        var result = [LinkSpanItem]()
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