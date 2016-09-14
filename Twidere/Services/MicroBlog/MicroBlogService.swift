//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SwiftyJSON
import PromiseKit
import Alamofire

class MicroBlogService: RestClient {
    
    var accountKey: UserKey!
    
    let statusQueries: [String: String] = [
        "tweet_mode": "extended"
    ]
    
    func verifyCredentials() -> Promise<JSON> {
        return makeTypedRequest(.GET, path: "/account/verify_credentials.json", validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertJSON)
    }
    
    func updateStatus(request: UpdateStatusRequest) -> Promise<Status> {
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
        return makeTypedRequest(.POST, path: "/statuses/update.json", params: forms, validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    func uploadMedia(media: NSData, additionalOwners: [String]? = nil) -> Promise<MediaUploadResponse> {
        var forms: [String:AnyObject] = ["media": media]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joinWithSeparator(",")
        }
        return makeTypedRequest(.POST, path: "/media/upload.json", params: forms, validation: MicroBlogService.checkRequest, serializer: MediaUploadResponse.serialization)
    }
    
    func initUploadMedia(mediaType: String, totalBytes: Int, additionalOwners: [String]? = nil) -> Promise<MediaUploadResponse> {
        var forms: [String:AnyObject] = ["command": "INIT", "media_type": mediaType, "total_bytes": "\(totalBytes)"]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joinWithSeparator(",")
        }
        return makeTypedRequest(.POST, path: "/media/upload.json", params: forms, validation: MicroBlogService.checkRequest, serializer: MediaUploadResponse.serialization)
    }
    
    func appendUploadMedia(mediaId: String, segmentIndex: Int, media: NSData) -> Promise<Int> {
        var forms: [String:AnyObject] = ["command": "APPEND", "media_id": mediaId, "segment_index": "\(segmentIndex)"]
        forms["media"] = media
        return makeTypedRequest(.POST, path: "/media/upload.json", params: forms, validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertResponseCode)
    }
    
    func finalizeUploadMedia(mediaId: String) -> Promise<MediaUploadResponse> {
        let forms: [String:AnyObject] = ["command": "FINALIZE", "media_id": mediaId]
        return makeTypedRequest(.POST, path: "/media/upload.json", params: forms, validation: MicroBlogService.checkRequest, serializer: MediaUploadResponse.serialization)
    }
    
    func getUploadMediaStatus(mediaId: String) -> Promise<MediaUploadResponse> {
        let queries: [String:String] = ["command": "STATUS", "media_id": mediaId]
        return makeTypedRequest(.POST, path: "/media/upload.json", queries: queries, validation: MicroBlogService.checkRequest, serializer: MediaUploadResponse.serialization)
    }
    
    func getHomeTimeline(paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, paging.queries)
        return makeTypedRequest(.GET, path: "/statuses/home_timeline.json", queries: queries, validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func getUserTimeline(screenName: String, paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["screen_name": screenName], paging.queries)
        return makeTypedRequest(.GET, path: "/statuses/user_timeline.json", queries: queries, validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func lookupStatuses(ids: [String]) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["id": ids.joinWithSeparator(",")])
        return makeTypedRequest(.GET, path: "/statuses/lookup.json", queries: queries, validation: MicroBlogService.checkRequest, serializer: MicroBlogService.convertStatuses(accountKey))
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
    
    static func checkRequest(req: NSURLRequest?, resp: NSHTTPURLResponse) -> Request.ValidationResult {
        if (resp.ok) {
            return .Success
        }
        let failureReason = "Response status code was unacceptable: \(resp.statusCode)"
        
        let error = NSError(
            domain: Error.Domain,
            code: Error.Code.StatusCodeValidationFailed.rawValue,
            userInfo: [
                NSLocalizedFailureReasonErrorKey: failureReason,
                Error.UserInfoKeys.StatusCode: resp.statusCode
            ]
        )
        
        return .Failure(error)
    }
    
    static let convertJSON = ResponseSerializer { (req, resp, data, err) -> Result<JSON, MicroBlogError> in
        if let data = data {
            return .Success(JSON(data: data))
        }
        return .Failure(.RequestError(code: resp?.statusCode ?? -1, message: nil))
    }
    
    static let convertResponseCode = ResponseSerializer { (req, resp, data, err) -> Result<Int, MicroBlogError> in
        if let resp = resp {
            return .Success(resp.statusCode)
        }
        return .Failure(.RequestError(code: resp?.statusCode ?? -1, message: nil))
    }
    
    static func convertStatus(accountKey: UserKey) -> ResponseSerializer<Status, MicroBlogError> {
        return convertMicroBlogResponse { Status(status: JSON(data: $0), accountKey: accountKey) }
    }
    
    static func convertStatuses(accountKey: UserKey) -> ResponseSerializer<[Status], MicroBlogError> {
        return convertMicroBlogResponse { Status.arrayFromJson(JSON(data: $0), accountKey: accountKey) }
    }
    
    
    static func convertMicroBlogResponse<T>(convert: (NSData) -> T?) -> ResponseSerializer<T, MicroBlogError> {
        return ResponseSerializer { (req, resp, data, err) -> Result<T, MicroBlogError> in
            if err != nil, let resp = resp {
                if let data = data {
                    let json = JSON(data: data)
                    let errors = json["errors"].map({ (_, error) -> MicroBlogError.ErrorInfo in
                        return MicroBlogError.ErrorInfo(code: error["code"].intValue, name: error["name"].string, message: error["message"].stringValue)
                    })
                    if (!errors.isEmpty) {
                        return .Failure(.ServiceError(errors: errors))
                    }
                }
                return .Failure(.RequestError(code: resp.statusCode, message: nil))
            } else if let data = data {
                guard let converted = convert(data) else {
                    return .Failure(.DecodeError)
                }
                return .Success(converted)
            }
            return .Failure(.NetworkError)
        }
    }

}

enum MicroBlogError: ErrorType {
    case NetworkError
    case ServiceError(errors: [ErrorInfo])
    case RequestError(code:Int, message:String?)
    case DecodeError
    
    struct ErrorInfo {
        let code: Int
        let name: String?
        let message: String
    }

}

extension MicroBlogError {
    var errorMessage: String {
        switch self {
        case .NetworkError:
            return "Network error"
        case .DecodeError:
            return "Server returned invalid response"
        case let .ServiceError(errors):
            return errors.first!.message
        case let .RequestError(code, message):
            // TODO return human readable message
            return "Request error \(code): \(message ?? "nil")"
        }
    }
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