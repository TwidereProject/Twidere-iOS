//
//  MediaUploadResponse.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Freddy
import Alamofire

class MediaUploadResponse: JSONDecodable {
    
    var mediaId: String!
    var size: Int64!
    var image: Image!
    var video: Video!
    var processingInfo: ProcessingInfo!
    
    required init(json: JSON) throws {
        mediaId = try? json.getString(at: "media_id")
        size = try? json.getInt64(at: "size")
        image = try? json.decode(at: "image")
        video = try? json.decode(at: "video")
        processingInfo = try? json.decode(at: "processing_info")
        
        if (mediaId == nil) {
            mediaId = try? json.getString(at: "media_id_string")
        }
        if (mediaId == nil) {
            let idInt = try json.getInt64(at: "media_id")
            mediaId = String(describing: idInt)
        }
    }
    
    class Image: JSONDecodable {
        
        var width: Int!
        var height: Int!
        var imageType: String!
        
        required init(json: JSON) throws {
            width = try json.decode(at: "w")
            height = try json.decode(at: "h")
            imageType = try json.decode(at: "image_type")
        }
        
    }
    
    class Video: JSONDecodable {
        
        var videoType: String!
        
        required init(json: JSON) throws {
            videoType = try json.decode(at: "video_type")
        }
        
    }
    
    class ProcessingInfo: JSONDecodable {
        
        var state: String!
        var checkAfterSecs: Int64!
        var progressPercent: Int!
//        var error: ErrorInfo!
        
        required init(json: JSON) throws {
            state = try json.decode(at: "state")
            checkAfterSecs = try? json.decode(at: "check_after_secs")
            progressPercent = try? json.decode(at: "progress_percent")
//            error = try json.decode("error")
        }
        
    }
    
    static let serialization = DataResponseSerializer<MediaUploadResponse> { (req, resp, data, err) -> Result<MediaUploadResponse> in
        if let data = data, let json = String(data: data, encoding: String.Encoding.utf8) {
            do {
                let response = try MediaUploadResponse(json: JSON(jsonString: json))
                return .success(response)
            } catch let err {
                return .failure(err)
            }
        }
        return .failure(MicroBlogError.decodeError)
    }
}
