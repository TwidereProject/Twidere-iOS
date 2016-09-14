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
        
        let BULK_SIZE = 256 * 1024// 128 Kib
        
        func uploadMedia(uploader: MediaUploader?, update: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> Promise<Bool> {
            // TODO on start uploading media
            if (uploader == nil) {
                return uploadMediaWithDefaultProvider(update, pendingUpdate: pendingUpdate)
            } else {
                return uploadMediaWithExtension(uploader!, update: update, pendingUpdate: pendingUpdate)
            }
        }
        
        func uploadMediaWithDefaultProvider(update: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> Promise<Bool> {
            // Return empty array if no media attached
            if (update.media?.isEmpty ?? true) {
                return Promise<Bool> { fullfill, reject in
                    fullfill(true)
                }
            }
            let owners = update.accounts.filter{ (account: Account) -> Bool in
                return account.typeInferred == .Twitter
                }.map { account -> UserKey in
                    return account.key!
            }
            let ownerIds = owners.map { key -> String in
                return key.id
            }
            pendingUpdate.sharedMediaOwners = owners
            return join((0..<pendingUpdate.length).map { i -> Promise<Bool> in
                let account = update.accounts[i]
                switch (account.typeInferred) {
                case .Twitter:
                    let upload = account.newMicroblogInstance("upload")
                    if (pendingUpdate.sharedMediaIds != nil) {
                        return Promise<Bool> { fullfill, reject in
                            pendingUpdate.mediaIds[i] = pendingUpdate.sharedMediaIds
                            fullfill(true)
                        }
                    }
                    return uploadAllMediaShared(upload, update: update, ownerIds: ownerIds, chucked: true)
                        .then { ids -> Bool in
                            pendingUpdate.mediaIds[i] = ids
                            pendingUpdate.sharedMediaIds = ids
                            return true
                    }
                case .Fanfou:
                    // Nope, fanfou uses photo uploading API
                    return Promise { fullfill, reject in
                        fullfill(true)
                    }
                case .StatusNet:
                    // TODO use their native API
                    let upload = account.newMicroblogInstance("upload")
                    return uploadAllMediaShared(upload, update: update, ownerIds: ownerIds, chucked: false)
                        .then { ids -> Bool in
                            pendingUpdate.mediaIds[i] = ids
                            return true
                    }
                }
                
                }).then { results -> Bool in
                    return true
            }
        }
        
        func uploadAllMediaShared(upload: MicroBlogService, update: StatusUpdate, ownerIds: [String], chucked: Bool) -> Promise<[String]> {
            return join(update.media!.map { media -> Promise<MediaUploadResponse> in
                // TODO upload then get id
                let fm = NSFileManager.defaultManager()
                let data = fm.contentsAtPath(media.path)!
                if (chucked) {
                    return uploadMediaChucked(upload, body: data, contentType: "image/jpeg", ownerIds: ownerIds)
                } else {
                    return upload.uploadMedia(data, additionalOwners: ownerIds)
                }
                }).then { responses -> [String] in
                    return responses.map { $0.mediaId }
            }
        }
        
        func uploadMediaChucked(upload: MicroBlogService, body: NSData, contentType: String, ownerIds: [String]) -> Promise<MediaUploadResponse> {
            let length = body.length
            return upload.initUploadMedia(contentType, totalBytes: length, additionalOwners: ownerIds)
                .then { (response) -> Promise<MediaUploadResponse> in
                    let segments = length == 0 ? 0 : length / BULK_SIZE + 1
                    
                    // Reject all if one task rejected
                    return join((0..<segments)
                        .map { (segmentIndex) -> Promise<Int> in
                            let currentBulkSize = min(BULK_SIZE, length - segmentIndex * BULK_SIZE)
                            let bulk = body.subdataWithRange(NSMakeRange(segmentIndex * BULK_SIZE, currentBulkSize))
                            return upload.appendUploadMedia(response.mediaId, segmentIndex: segmentIndex, media: bulk)
                        }).then { responses -> MediaUploadResponse in
                            return response
                    }
                }.then { response -> Promise<MediaUploadResponse> in
                    return upload.finalizeUploadMedia(response.mediaId)
                }.then { response -> Promise<MediaUploadResponse> in
                    
                    func waitForProcess(response: MediaUploadResponse) -> Promise<MediaUploadResponse> {
                        // Server side is processing media
                        if let checkAfterSecs = response.processingInfo?.checkAfterSecs where checkAfterSecs > 0 {
                            // Wait after `checkAfterSecs` seconds
                            after(NSTimeInterval(checkAfterSecs))
                                .then{ _ -> Promise<MediaUploadResponse> in
                                    // Fetch new upload status
                                    return upload.getUploadMediaStatus(response.mediaId)
                                }.then { newResp -> Promise<MediaUploadResponse> in
                                    // Recursions are bad, but it's the only possible way in Promise
                                    return waitForProcess(newResp)
                            }
                        }
                        // No processing info available, check failed or completed instead
                        return Promise { fullfill, reject in
                            if (response.processingInfo?.state == "failed") {
                                reject(MicroBlogError.RequestError(code: 0, message: "uploadMediaChucked"))
                            }
                            fullfill(response)
                        }
                    }
                    
                    return waitForProcess(response)
            }
        }
        
        func uploadMediaWithExtension(uploader: MediaUploader, update: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> Promise<Bool> {
            return Promise { fullfill, reject in
                reject(NSError(domain: "uploadMediaWithExtension not implemented", code: -1, userInfo: nil))
            }
        }
        
        func requestUpdateStatus(statusUpdate: StatusUpdate, pendingUpdate: PendingStatusUpdate) -> Promise<[Status]> {
            return when((0..<pendingUpdate.length)
                .map { i -> Promise<(Status?, (UserKey, ErrorType)?)> in
                    let account = statusUpdate.accounts[i]
                    let microBlog = account.newMicroblogInstance("api")
                    return Promise { fullfill, reject in
                        let statusPromise: Promise<Status>
                        switch (account.typeInferred) {
                        default:
                            statusPromise = twitterUpdateStatus(microBlog, statusUpdate: statusUpdate, pendingUpdate: pendingUpdate, overrideText: pendingUpdate.overrideTexts[i], index: i)
                        }
                        statusPromise.then { status -> Void in
                            fullfill((status, nil))
                            }.error { error in
                                fullfill((nil, (account.key!, error)))
                        }
                    }
                }).then { results -> [Status] in
                    if (results.contains { $0.0 == nil }) {
                        // Throw errors
                        let errors = results.filter{ $0.1 != nil }.map { $0.1!.1 }
                        let failedKeys = results.filter{ $0.1 != nil }.map { $0.1!.0 }
                        throw StatusUpdateError.UpdateFailed(errors: errors, failedKeys: failedKeys)
                    }
                    return results.map { $0.0! }
            }
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
        
        uploadMedia(uploader, update: update, pendingUpdate: pendingUpdate)
            .then { succeed in
                return requestUpdateStatus(update, pendingUpdate: pendingUpdate)
            }.then { result -> Void in
                JDStatusBarNotification.showWithStatus("Tweet sent!", dismissAfter: 1.5, styleName: JDStatusBarStyleSuccess)
            }.always {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }.error { error in
                let errorMessage: String
                switch error {
                case let updateError as StatusUpdateError:
                    switch updateError {
                    case .NoAccount:
                        errorMessage = "No account"
                    case .UploadFailed:
                        errorMessage = "Upload error"
                    case let .UpdateFailed(errors, failedKeys):
                        switch errors.first! {
                        case let e as MicroBlogError:
                            errorMessage = e.errorMessage
                        default:
                            errorMessage = String(errors.first!)
                        }
                    }
                default:
                    errorMessage = String(error)
                }
                JDStatusBarNotification.showWithStatus(errorMessage, dismissAfter: 1.5, styleName: JDStatusBarStyleError)
        }
    }
    
    enum StatusUpdateError: ErrorType {
        case NoAccount
        case UploadFailed
        case UpdateFailed(errors: [ErrorType], failedKeys: [UserKey])
    }
    
}

extension BackgroundOperationService.StatusUpdateError {
    var errorMessage: String {
        switch self {
        case .NoAccount:
            return "No account selected"
        case .UploadFailed:
            return "Media upload failed"
        case .UpdateFailed(let errors, _):
            switch errors.first! {
            case let e as MicroBlogError:
                return e.errorMessage
            default:
                return "Unkown error"
            }
        }
    }
}

protocol MediaUploader {
    
}