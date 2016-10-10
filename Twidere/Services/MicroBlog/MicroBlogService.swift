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
        "include_entities": "true",
        "include_ext_alt_text": "true",
        "tweet_mode": "extended",
        "model_version": "7",
        "include_cards": "true",
        "cards_platform": "iPhone-8"
    ]
    
    func verifyCredentials() -> Promise<JSON> {
        return makeTypedRequest(.get, path: "/account/verify_credentials.json", serializer: MicroBlogService.convertJSON)
    }
    
    // MARK: Timeline functions
    
    func getHomeTimeline(_ paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, paging.queries)
        return makeTypedRequest(.get, path: "/statuses/home_timeline.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func getUserTimeline(screenName: String, paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["screen_name": screenName], paging.queries)
        return makeTypedRequest(.get, path: "/statuses/user_timeline.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func getUserTimeline(id: String, paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["user_id": id], paging.queries)
        return makeTypedRequest(.get, path: "/statuses/user_timeline.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    // MARKER: Tweet functions
    
    func showStatus(id: String) -> Promise<Status> {
        let queries = makeQueries(statusQueries, ["id": id])
        return makeTypedRequest(.get, path: "/statuses/show.json", queries: queries, serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    func lookupStatuses(ids: [String]) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["id": ids.joined(separator: ",")])
        return makeTypedRequest(.get, path: "/statuses/lookup.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func retweetStatus(id: String) -> Promise<Status> {
        return makeTypedRequest(.post, path: "/statuses/retweet/\(id).json", serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    func unretweetStatus(id: String) -> Promise<Status> {
        return makeTypedRequest(.post, path: "/statuses/unretweet/\(id).json", serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    // MARKER: Favorite functions
    
    func getFavorites(screenName: String, paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["screen_name": screenName], paging.queries)
        return makeTypedRequest(.get, path: "/favorites/list.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func getFavorites(id: String, paging: Paging) -> Promise<[Status]> {
        let queries = makeQueries(statusQueries, ["user_id": id], paging.queries)
        return makeTypedRequest(.get, path: "/favorites/list.json", queries: queries, serializer: MicroBlogService.convertStatuses(accountKey))
    }
    
    func createFavorite(id: String) -> Promise<Status> {
        let queries = makeQueries(statusQueries, ["id": id])
        return makeTypedRequest(.post, path: "/favorites/create.json", queries: queries, serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    func destroyFavorite(id: String) -> Promise<Status> {
        let queries = makeQueries(statusQueries, ["id": id])
        return makeTypedRequest(.post, path: "/favorites/destroy.json", queries: queries, serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    // MARK: Activity functions
    
    func getActivitiesAboutMe(paging: Paging) -> Promise<[Activity]> {
        let queries = makeQueries(statusQueries, paging.queries)
        return makeTypedRequest(.get, path: "/activity/about_me.json", queries: queries, serializer: MicroBlogService.convertActivities(accountKey))
    }
    
    // MARK: User functions
    
    func showUser(id: String) -> Promise<User> {
        let queries: [String: String] = ["user_id": id]
        return makeTypedRequest(.get, path: "/users/show.json", queries: queries, serializer: MicroBlogService.convertUser(accountKey))
    }
    
    func showUser(screenName: String) -> Promise<User> {
        let queries: [String: String] = ["screen_name": screenName]
        return makeTypedRequest(.get, path: "/users/show.json", queries: queries, serializer: MicroBlogService.convertUser(accountKey))
    }
    
    func updateStatus(_ request: UpdateStatusRequest) -> Promise<Status> {
        var forms: [String: Any] = ["status": request.text]
        if (request.mediaIds != nil) {
            forms["media_ids"] = request.mediaIds?.joined(separator: ",")
        }
        if let location = request.location {
            forms["lat"] = String(format: "%f", location.latitude)
            forms["long"] = String(format: "%f", location.longitude)
            forms["display_coordinates"] = request.displayCoordinates ? "true" : "false"
        }
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
        return makeTypedRequest(.post, path: "/statuses/update.json", params: forms, serializer: MicroBlogService.convertStatus(accountKey))
    }
    
    func uploadMedia(_ media: Data, additionalOwners: [String]? = nil) -> Promise<MediaUploadResponse> {
        var forms: [String:Any] = ["media": media]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joined(separator: ",")
        }
        return makeTypedRequest(.post, path: "/media/upload.json", params: forms, serializer: MediaUploadResponse.serialization)
    }
    
    func initUploadMedia(_ mediaType: String, totalBytes: Int, additionalOwners: [String]? = nil) -> Promise<MediaUploadResponse> {
        var forms: [String:Any] = ["command": "INIT", "media_type": mediaType, "total_bytes": "\(totalBytes)"]
        if (additionalOwners != nil) {
            forms["additional_owners"] = additionalOwners!.joined(separator: ",")
        }
        return makeTypedRequest(.post, path: "/media/upload.json", params: forms, serializer: MediaUploadResponse.serialization)
    }
    
    func appendUploadMedia(_ mediaId: String, segmentIndex: Int, media: Data) -> Promise<Int> {
        var forms: [String:Any] = ["command": "APPEND", "media_id": mediaId, "segment_index": "\(segmentIndex)"]
        forms["media"] = media
        return makeTypedRequest(.post, path: "/media/upload.json", params: forms, serializer: MicroBlogService.convertResponseCode)
    }
    
    func finalizeUploadMedia(_ mediaId: String) -> Promise<MediaUploadResponse> {
        let forms: [String:Any] = ["command": "FINALIZE", "media_id": mediaId]
        return makeTypedRequest(.post, path: "/media/upload.json", params: forms, serializer: MediaUploadResponse.serialization)
    }
    
    func getUploadMediaStatus(_ mediaId: String) -> Promise<MediaUploadResponse> {
        let queries: [String:String] = ["command": "STATUS", "media_id": mediaId]
        return makeTypedRequest(.post, path: "/media/upload.json", queries: queries, serializer: MediaUploadResponse.serialization)
    }
    
    func makeQueries(_ def: [String: String], _ queries: [String: String]...) -> [String: String] {
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
    
    static let convertJSON = DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<JSON> in
        if let data = data {
            return .success(JSON(data: data))
        }
        return .failure(MicroBlogError.requestError(code: resp?.statusCode ?? -1, message: nil))
    }
    
    static let convertResponseCode = DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<Int> in
        if let resp = resp {
            return .success(resp.statusCode)
        }
        return .failure(MicroBlogError.requestError(code: resp?.statusCode ?? -1, message: nil))
    }
    
    static func convertUser(_ accountKey: UserKey) -> DataResponseSerializer<User> {
        return convertMicroBlogResponse { User(json: JSON(data: $0), accountKey: accountKey) }
    }
    
    static func convertStatus(_ accountKey: UserKey) -> DataResponseSerializer<Status> {
        return convertMicroBlogResponse { Status(status: JSON(data: $0), accountKey: accountKey) }
    }
    
    static func convertStatuses(_ accountKey: UserKey) -> DataResponseSerializer<[Status]> {
        return convertMicroBlogResponse { Status.arrayFromJson(JSON(data: $0), accountKey: accountKey) }
    }
    
    
    static func convertActivities(_ accountKey: UserKey) -> DataResponseSerializer<[Activity]> {
        return convertMicroBlogResponse { Activity.arrayFromJson(JSON(data: $0), accountKey: accountKey) }
    }
    
    
    static func convertMicroBlogResponse<T>(_ convert: @escaping (Data) -> T?) -> DataResponseSerializer<T> {
        return DataResponseSerializer { (req, resp, data, err) -> Alamofire.Result<T> in
            if err != nil, let resp = resp {
                if let data = data {
                    let json = JSON(data: data)
                    let errors = json["errors"].map({ (_, error) -> MicroBlogError.ErrorInfo in
                        return MicroBlogError.ErrorInfo(code: error["code"].intValue, name: error["name"].string, message: error["message"].stringValue)
                    })
                    if (!errors.isEmpty) {
                        return .failure(MicroBlogError.serviceError(errors: errors))
                    }
                }
                return .failure(MicroBlogError.requestError(code: resp.statusCode, message: nil))
            } else if let data = data {
                guard let converted = convert(data) else {
                    return .failure(MicroBlogError.decodeError)
                }
                return .success(converted)
            }
            return .failure(MicroBlogError.networkError)
        }
    }

}

enum MicroBlogError: Error {
    case networkError
    case serviceError(errors: [ErrorInfo])
    case requestError(code:Int, message:String?)
    case decodeError
    case argumentError(message: String?)
    
    struct ErrorInfo {
        let code: Int
        let name: String?
        let message: String
    }

}

extension MicroBlogError {
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Network error"
        case .decodeError:
            return "Server returned invalid response"
        case let .serviceError(errors):
            return errors.first!.message
        case let .requestError(code, message):
            // TODO return human readable message
            return "Request error \(code): \(message ?? "nil")"
        default:
            return "Internal error"
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
