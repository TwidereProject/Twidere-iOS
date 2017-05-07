//
//  StatusUpdate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import TwidereCore
import MicroBlog

class StatusUpdate {
    var accounts: [AccountDetails]
    var text: String
    var media: [MediaUpdate]? = nil
    var location: GeoLocation? = nil
    var displayCoordinates: Bool = false
    var inReplyToStatus: PersistableStatus? = nil
    var repostStatusId: String? = nil
    var attachmentUrl: String? = nil
    var possiblySensitive: Bool = false
    
    init(accounts: [AccountDetails], text: String) {
        self.accounts = accounts
        self.text = text
    }
    
}

class PendingStatusUpdate {
    
    let length: Int
    
    var sharedMediaIds: [String]? = nil
    var sharedMediaOwners: [UserKey]? = nil
    
    var overrideTexts: [String]
    var mediaIds: [[String]?]
    
    var mediaUploadResults: [MediaUploadResult?]
    var statusShortenResults: [StatusShortenResult?]
    
    init(length: Int, defaultText: String) {
        self.length = length
        overrideTexts = Array(repeating: defaultText, count: length)
        mediaUploadResults = Array(repeating: nil, count: length)
        statusShortenResults = Array(repeating: nil, count: length)
        mediaIds = Array(repeating: nil, count: length)
    }
    
}

class MediaUpdate {
    var path: String
    var type: MediaType
    var altText: String? = nil
    
    init(path: String, type: MediaType) {
        self.path = path
        self.type = type
    }
    
    enum MediaType: String {
        case image, video
    }
}

class MediaUploadResult {
    
}

class StatusShortenResult {
    
}

class UpdateStatusResult {
    let statuses: [PersistableStatus]
    
    init(statuses: [PersistableStatus]) {
        self.statuses = statuses
    }
    
}
