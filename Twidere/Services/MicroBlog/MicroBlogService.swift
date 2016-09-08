//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON

class MicroBlogService: RestClient {
    
    let statusQueries: [String: String] = [
        "tweet_mode": "extended"
    ]

    func verifyCredentials() throws -> JSON {
        return try makeTypedRequest(.GET, path: "/account/verify_credentials.json", checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }

    func updateStatus(request: UpdateStatusRequest) throws -> JSON {
        var forms: [String:AnyObject] = ["status": request.text]
        if (request.mediaIds != nil) {
            forms["media_ids"] = request.mediaIds?.joinWithSeparator(",")
        }
        if (request.location != nil) {
            forms["lat"] = request.location!.latitude
            forms["long"] = request.location!.longitude
        }
        forms["display_coordinates"] = request.displayCoordinates ? "true" : "false"
        if (request.inReplyToStatusId != nil) {
            forms["in_reply_to_status_id"] = request.inReplyToStatusId!
        }
        if (request.repostStatusId != nil) {
            forms["repost_status_id"] = request.repostStatusId
        }
        if (request.attachmentUrl != nil) {
            forms["attachment_url"] = request.attachmentUrl
        }
        forms["possibly_sensitive"] = request.possiblySensitive ? "true" : "false"
        return try makeTypedRequest(.POST, path: "/statuses/update.json", forms: forms,
                checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func uploadMedia(media: NSData, additionalOwners: [String]? = nil) throws -> JSON {
        var forms: [String:AnyObject] = ["media": media]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joinWithSeparator(",")
        }
        return try makeTypedRequest(.POST, path: "/media/upload.json", forms: forms,
                                    checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func initUploadMedia(mediaType: String, totalBytes: Int, additionalOwners: [String]? = nil) throws -> JSON {
        var forms: [String:AnyObject] = ["command": "INIT", "media_type": mediaType, "total_bytes": "\(totalBytes)"]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joinWithSeparator(",")
        }
        return try makeTypedRequest(.POST, path: "/media/upload.json", forms: forms,
                                    checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func appendUploadMedia(mediaId: String, segmentIndex: Int, media: NSData) throws -> JSON {
        var forms: [String:AnyObject] = ["command": "APPEND", "media_id": mediaId, "segment_index": "\(segmentIndex)"]
        forms["media"] = media
        return try makeTypedRequest(.POST, path: "/media/upload.json", forms: forms,
                                    checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func finalizeUploadMedia(mediaId: String) throws -> JSON {
        let forms: [String:AnyObject] = ["command": "FINALIZE", "media_id": mediaId]
        return try makeTypedRequest(.POST, path: "/media/upload.json", forms: forms,
                                    checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func getUploadMediaStatus(mediaId: String) throws -> JSON {
        let queries: [String:String] = ["command": "STATUS", "media_id": mediaId]
        return try makeTypedRequest(.POST, path: "/media/upload.json", queries: queries,
                                    checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func getHomeTimeline(paging: Paging) throws -> JSON {
        let queries = makeQueries(statusQueries, paging.queries)
        return try makeTypedRequest(.GET, path: "/statuses/home_timeline.json", queries: queries, checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func getUserTimeline(screenName: String, paging: Paging) throws -> JSON {
        let queries = makeQueries(statusQueries, ["screen_name": screenName], paging.queries)
        return try makeTypedRequest(.GET, path: "/statuses/user_timeline.json", queries: queries, checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func lookupStatuses(ids: [String]) throws -> JSON {
        let queries = makeQueries(statusQueries, ["id": ids.joinWithSeparator(",")])
        return try makeTypedRequest(.GET, path: "/statuses/lookup.json", queries: queries, checker: MicroBlogService.checkRequest, converter: MicroBlogService.convertJSON)
    }
    
    func makeQueries(def: [String: String], _ queries: [String: String]...) -> [String: String] {
        var result = [String: String]()
        for (k, v) in def {
            result[k] = v
        }
        for dict in queries {
            for (k,v) in dict {
                result[k] = v
            }
        }
        return result
    }

    static func checkRequest(result: HttpResult) throws {
        if (!(result.response?.ok ?? false)) {
            if let data = result.data {
                let json = JSON(data)
                let code = json["errors"][0]["code"].int ?? -1
                let message = json["errors"][0]["message"].string
                throw MicroBlogError.RequestError(code: code, message: message)
            }
        }
    }

    static func convertJSON(result: HttpResult) -> JSON {
        return SwiftyJSON.JSON(data: result.data!)
    }
}

enum MicroBlogError: ErrorType {
    case RequestError(code:Int, message:String?)
}

class UpdateStatusRequest {
    var text: String
    var mediaIds: [String]? = nil
    var location: GeoLocation? = nil
    var displayCoordinates: Bool = false
    var inReplyToStatusId: String? = nil
    var repostStatusId: String? = nil
    var attachmentUrl: String? = nil
    var possiblySensitive: Bool = false

    init(text: String) {
        self.text = text
    }
}