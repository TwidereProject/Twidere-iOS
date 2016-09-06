//
//  BackgroundOperationService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit
import UIKit
import JDStatusBarNotification
import SwiftyJSON

class BackgroundOperationService {

    func updateStatus(update: StatusUpdate) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_promise {
            () -> UpdateStatusResult in
            let BULK_SIZE = 256 * 1024// 128 Kib
            
            func uploadMedia(uploader: MediaUploader?, update: StatusUpdate, pendingUpdate: PendingStatusUpdate) throws {
                // TODO on start uploading media
                if (uploader == nil) {
                    try uploadMediaWithDefaultProvider(update, pendingUpdate: pendingUpdate)
                } else {
                    uploadMediaWithExtension(uploader!, update: update, pendingUpdate: pendingUpdate)
                }
            }
            
            func uploadMediaWithDefaultProvider(update: StatusUpdate, pendingUpdate: PendingStatusUpdate) throws {
                // Return empty array if no media attached
                if (update.media?.isEmpty ?? true) {
                    return
                }
                let owners = update.accounts.filter{ (account: Account) -> Bool in
                    return account.typeInferred == .Twitter
                }.map { account -> UserKey in
                    return UserKey(rawValue: account.accountKey!)
                }
                let ownerIds = owners.map { key -> String in
                    return key.id
                }
                for i in 0..<pendingUpdate.length {
                    let account = update.accounts[i]
                    let mediaIds: [String]?
                    switch (account.typeInferred) {
                    case .Twitter:
                            let upload = account.newMicroblogInstance("upload")
                            if (pendingUpdate.sharedMediaIds != nil) {
                                mediaIds = pendingUpdate.sharedMediaIds
                            } else {
                                mediaIds = try uploadAllMediaShared(upload, update: update, ownerIds: ownerIds, chucked: true)
                                pendingUpdate.sharedMediaIds = mediaIds
                            }
                        
                    case .Fanfou:
                            // Nope, fanfou uses photo uploading API
                        mediaIds = nil
                    case .StatusNet:
                            // TODO use their native API
                            let upload = account.newMicroblogInstance("upload")
                            mediaIds = try uploadAllMediaShared(upload, update: update, ownerIds: ownerIds, chucked: false)
                    }
                    pendingUpdate.mediaIds[i] = mediaIds
                }
                pendingUpdate.sharedMediaOwners = owners
            }
            
            func uploadAllMediaShared(upload: MicroBlogService, update: StatusUpdate, ownerIds: [String], chucked: Bool) throws -> [String] {
                return try update.media!.enumerate().map{ (index, media) throws -> String in
                    // TODO upload then get id
                    let fm = NSFileManager.defaultManager()
                    let data = fm.contentsAtPath(media.path)!
                    let json: JSON
                    if (chucked) {
                        json = try uploadMediaChucked(upload, body: data, contentType: "image/jpeg", ownerIds: ownerIds)
                    } else {
                        json = try upload.uploadMedia(data, additionalOwners: ownerIds)
                    }
                    return json["media_id_string"].stringValue
                }
            }

            func uploadMediaChucked(upload: MicroBlogService, body: NSData, contentType: String, ownerIds: [String]) throws -> JSON {
                let length = body.length
                var response = try upload.initUploadMedia(contentType, totalBytes: length, additionalOwners: ownerIds)
                let id = response["media_id"].stringValue
                if (id.isEmpty) {
                    // TODO control flow
                    throw NSError(domain: "uploadMediaChucked", code: 0, userInfo: nil)
                }
                let segments = length == 0 ? 0 : length / BULK_SIZE + 1
                for segmentIndex in 0..<segments {
                    let currentBulkSize = min(BULK_SIZE, length - segmentIndex * BULK_SIZE)
                    let bulk = body.subdataWithRange(NSMakeRange(segmentIndex * BULK_SIZE, currentBulkSize))
                    try upload.appendUploadMedia(id, segmentIndex: segmentIndex, media: bulk)
                }
                response = try upload.finalizeUploadMedia(id)
                var info = response["processing_info"]
                while (info["check_after_secs"].isExists()) {
                    guard let checkAfterSecs = info["check_after_secs"].uInt32 else {
                        break
                    }
                    sleep(checkAfterSecs)
                    response = try upload.getUploadMediaStatus(id)
                    info = response["processing_info"]
                }
                if (info["state"].string == "failed") {
                    throw NSError(domain: "uploadMediaChucked", code: 0, userInfo: nil)
                }
                return response
            }
            
            func uploadMediaWithExtension(uploader: MediaUploader, update: StatusUpdate, pendingUpdate: PendingStatusUpdate) {
                
            }
            
            func requestUpdateStatus(statusUpdate: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> UpdateStatusResult {
                var statuses: [FlatStatus?] = Array(count: pendingUpdate.length, repeatedValue: nil)
                var exceptions: [ErrorType?] = Array(count: pendingUpdate.length, repeatedValue: nil)

                for i in 0 ..< pendingUpdate.length {
                    let account = statusUpdate.accounts[i]
                    let microBlog = account.newMicroblogInstance("api")
                    switch (account.accountType) {
                    default:
                        do {
                            let requestResult = try twitterUpdateStatus(microBlog, statusUpdate: statusUpdate, pendingUpdate: pendingUpdate, overrideText: pendingUpdate.overrideTexts[i], index: i)
                            let status = FlatStatus(status: requestResult, account: account)
                            statuses[i] = status
                        } catch let error {
                            exceptions[i] = error
                        }
                    }
                }
                return UpdateStatusResult(statuses: statuses, exceptions: exceptions)
            }

            func twitterUpdateStatus(microBlog: MicroBlogService, statusUpdate: StatusUpdate,
                                     pendingUpdate: PendingStatusUpdate, overrideText: String,
                                     index: Int) throws -> JSON {
                let status = UpdateStatusRequest(text: overrideText)
                if (statusUpdate.inReplyToStatus != nil) {
                    status.inReplyToStatusId = statusUpdate.inReplyToStatus!.id
                }
                if (statusUpdate.repostStatusId != nil) {
                    status.repostStatusId = statusUpdate.repostStatusId
                }
                if (statusUpdate.attachmentUrl != nil) {
                    status.attachmentUrl = statusUpdate.attachmentUrl
                }
                if (statusUpdate.location != nil) {
                    status.location = statusUpdate.location
                    status.displayCoordinates = statusUpdate.displayCoordinates
                }
                if let mediaIds = pendingUpdate.mediaIds[index] {
                    status.mediaIds = mediaIds
                }
                status.possiblySensitive = statusUpdate.possiblySensitive
                return try microBlog.updateStatus(status)
            }
            
            let uploader: MediaUploader? = nil

            let pendingUpdate = PendingStatusUpdate(length: update.accounts.count, defaultText: update.text)
            
            try uploadMedia(uploader, update: update, pendingUpdate: pendingUpdate)
            let result: UpdateStatusResult = requestUpdateStatus(update, pendingUpdate: pendingUpdate)
            if (!result.successful) {
                throw StatusUpdateError.SendFailed
            }
            return result
        }.then { result -> Void in
            JDStatusBarNotification.showWithStatus("Tweet sent!", dismissAfter: 1.5, styleName: JDStatusBarStyleSuccess)
        }.always {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }.error { error in
            debugPrint(error)
            JDStatusBarNotification.showWithStatus("\(error)", dismissAfter: 1.5, styleName: JDStatusBarStyleError)
        }
    }
    
    enum StatusUpdateError: ErrorType {
        case UploadError
        case SendFailed
    }
}

protocol MediaUploader {
    
}