//
//  StatusUpdate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

typealias GeoLocation = (latitude: Double, longitude: Double)

class StatusUpdate {
    var accounts: [Account]
    var text: String
    var media: [MediaUpdate]? = nil
    var location: GeoLocation? = nil
    var displayCoordinates: Bool = false
    var inReplyToStatus: Status? = nil
    var repostStatusId: String? = nil
    var attachmentUrl: String? = nil
    var possiblySensitive: Bool = false
    
    init(accounts: [Account], text: String) {
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
        overrideTexts = Array(count: length, repeatedValue: defaultText)
        mediaUploadResults = Array(count: length, repeatedValue: nil)
        statusShortenResults = Array(count: length, repeatedValue: nil)
        mediaIds = Array(count: length, repeatedValue: nil)
    }
    
}

class MediaUpdate {
    var path: String
    var type: Type
    var altText: String? = nil
    
    init(path: String, type: Type) {
        self.path = path
        self.type = type
    }
    
    enum Type: String {
        case Image, Video
    }
}

class MediaUploadResult {
    
}

class StatusShortenResult {
    
}

class UpdateStatusResult {
    let statuses: [Status?]
    let exceptions: [ErrorType?]
    
    let exception: ErrorType?
    
    var successful: Bool {
        get {
            for item in statuses {
                if (item == nil) {
                    return false
                }
            }
            return true
        }
    }
    
    init(statuses: [Status?], exceptions: [ErrorType?]) {
        self.statuses = statuses
        self.exceptions = exceptions
        self.exception = nil
    }
    
    init(exception: ErrorType) {
        self.exception = exception
        self.statuses = []
        self.exceptions = []
    }
}
