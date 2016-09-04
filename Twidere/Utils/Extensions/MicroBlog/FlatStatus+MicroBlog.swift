//
//  FlatStatus+JSON.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/1.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension FlatStatus {
    
    convenience init(status: JSON, account: Account) {
        self.init()
        self.accountKey = UserKey(str: account.accountKey!)
        self.id = getTwitterEntityId(status)
        self.createdAt = parseTwitterDate(status["created_at"].stringValue)
        
        var primary = status["retweeted_status"]
        if (primary.isExists()) {
            
        } else {
            primary = status
        }
 
        let user = primary["user"]
        let userId = getTwitterEntityId(user)
        self.userKey = UserKey(id: userId, host: self.accountKey.host)
        self.userName = user["name"].string
        self.userScreenName = user["screen_name"].string
        self.userProfileImage = getProfileImage(user)
        
        self.textPlain = primary["text"].string
        
        let (textDisplay, metadata) = getMetadata(primary)
        
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
            
            self.quotedTextPlain = quoted["text"].string
            
            
            let (quotedTextDisplay, quotedMetadata) = getMetadata(quoted)
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
    
    private func getMetadata(status: JSON) -> (String!, Metadata) {
        let metadata = Metadata()
        var spans = [SpanItem]()
        let text = status["full_text"].string ?? status["text"].string!
        var codePoints = text.unicodeScalars
        
        
        var codePointOffset = 0
        
        var urlEntities = [JSON]()
        urlEntities.appendContentsOf(status["entities"]["urls"].arrayValue)
        if let extendedMedia = status["extended_entities"]["media"].array {
            urlEntities.appendContentsOf(extendedMedia)
        } else if let media = status["entities"]["media"].array {
            urlEntities.appendContentsOf(media)
        }
        var indices = [Range<Int>]()
        
        // Remove duplicate entities
        urlEntities = urlEntities.filter { entity -> Bool in
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
        urlEntities.sortInPlace { (l, r) -> Bool in
            return l["indices"][0].intValue < r["indices"][0].intValue
        }
        
        for urlEntity in urlEntities {
            guard let start = urlEntity["indices"][0].int, let end = urlEntity["indices"][1].int else {
                continue
            }
            guard let expandedUrl = urlEntity["expanded_url"].string else {
                continue
            }
            guard let displayUrl = urlEntity["display_url"].string else {
                continue
            }
            let displayUrlCodePoints = displayUrl.unicodeScalars
            let displayLength = displayUrlCodePoints.count
            let rangeStart = codePointOffset + start
            let rangeEnd = codePointOffset + end
            
            var startIndex = codePoints.startIndex
            
            codePoints.replaceRange(startIndex.advancedBy(rangeStart)..<startIndex.advancedBy(rangeEnd), with: displayUrlCodePoints)
            
            startIndex = codePoints.startIndex
            
            let spanStart = codePoints.utf16Count(startIndex..<startIndex.advancedBy(rangeStart))
            let spanEnd = spanStart + displayUrl.utf16.count
            let span = SpanItem(start: spanStart, end: spanEnd, link: expandedUrl)
            span.origStart = start
            span.origEnd = end
            spans.append(span)
            codePointOffset += displayLength - (end - start)
        }
        metadata.spans = spans
        metadata.displayRange = calculateDisplayTextRange(status, source: text, display: codePoints, spans: spans)
        return (String(codePoints), metadata)
    }
    
    private func calculateDisplayTextRange(status: JSON, source: String, display: String.UnicodeScalarView, spans:[SpanItem]) -> [Int]? {
        guard let start = status["display_text_range"][0].int, let end = status["display_text_range"][1].int else {
            return nil
        }
        let sourceCodePoints = source.unicodeScalars
        return [
            getResultRangeLength(sourceCodePoints, spans: spans, origStart: 0, origEnd: start),
            display.utf16Count() - getResultRangeLength(sourceCodePoints, spans: spans, origStart: end, origEnd: sourceCodePoints.count)
        ]
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
}