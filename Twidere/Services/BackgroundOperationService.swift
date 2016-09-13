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
        dispatch_promise { () -> UpdateStatusResult in
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
                        return account.key!
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
                    let promise: Promise<MediaUploadResponse>
                    if (chucked) {
                        promise = uploadMediaChucked(upload, body: data, contentType: "image/jpeg", ownerIds: ownerIds)
                    } else {
                        promise = upload.uploadMedia(data, additionalOwners: ownerIds)
                    }
                    while (promise.pending) {}
                    if (promise.fulfilled) {
                        return promise.value!.mediaId
                    } else {
                        throw promise.error!
                    }
                }
            }
            
            func uploadMediaChucked(upload: MicroBlogService, body: NSData, contentType: String, ownerIds: [String]) -> Promise<MediaUploadResponse> {
                let length = body.length
                return upload.initUploadMedia(contentType, totalBytes: length, additionalOwners: ownerIds).then { (response) -> Promise<MediaUploadResponse> in
                    let segments = length == 0 ? 0 : length / BULK_SIZE + 1
                    return when((0..<segments).map { (segmentIndex) -> Promise<Int> in
                        let currentBulkSize = min(BULK_SIZE, length - segmentIndex * BULK_SIZE)
                        let bulk = body.subdataWithRange(NSMakeRange(segmentIndex * BULK_SIZE, currentBulkSize))
                        return upload.appendUploadMedia(response.mediaId, segmentIndex: segmentIndex, media: bulk)
                        }).then { responses -> MediaUploadResponse in
                            return response
                    }
                    }.then { response -> Promise<MediaUploadResponse> in
                        return upload.finalizeUploadMedia(response.mediaId)
                    }.then { response -> Promise<MediaUploadResponse> in
                        return Promise { fullfill, reject in
                            var info = response.processingInfo
                            while (info?.checkAfterSecs > 0) {
                                sleep(UInt32(info!.checkAfterSecs!))
                                upload.getUploadMediaStatus(response.mediaId).then { response -> Void in
                                    info = response.processingInfo
                                }
                            }
                            if (info.state == "failed") {
                                reject(MicroBlogError.RequestError(code: 0, message: "uploadMediaChucked"))
                            }
                            fullfill(response)
                        }
                }
            }
            
            func uploadMediaWithExtension(uploader: MediaUploader, update: StatusUpdate, pendingUpdate: PendingStatusUpdate) {
                
            }
            
            func requestUpdateStatus(statusUpdate: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> UpdateStatusResult {
                var statuses: [Status?] = Array(count: pendingUpdate.length, repeatedValue: nil)
                var exceptions: [ErrorType?] = Array(count: pendingUpdate.length, repeatedValue: nil)
                
                for i in 0 ..< pendingUpdate.length {
                    let account = statusUpdate.accounts[i]
                    let microBlog = account.newMicroblogInstance("api")
                    switch (account.type) {
                    default:
                        let promise = twitterUpdateStatus(microBlog, statusUpdate: statusUpdate, pendingUpdate: pendingUpdate, overrideText: pendingUpdate.overrideTexts[i], index: i)
                        while (promise.pending) {}
                        statuses[i] = promise.value
                        exceptions[i] = promise.error
                    }
                }
                return UpdateStatusResult(statuses: statuses, exceptions: exceptions)
            }
            
            func twitterUpdateStatus(microBlog: MicroBlogService, statusUpdate: StatusUpdate,
                pendingUpdate: PendingStatusUpdate, overrideText: String,
                index: Int) -> Promise<Status> {
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
                return microBlog.updateStatus(status)
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