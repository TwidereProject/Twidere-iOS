//
//  MediaUploadResponse.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

struct MediaUploadResponse: JSONDecodable {
    
    var mediaId: String!
    var size: Int64!
    var image: Image!
    var video: Video!
    var processingInfo: ProcessingInfo!
    
    init(json value: JSON) throws {
        mediaId = try? value.decode(at: "media_id")
        size = try? value.decode(at: "size")
        if let imageJson = value["image"] {
            image = try? Image(json: imageJson)
        }
        
        if let videoJson = value["video"] {
            video = try? Video(json: videoJson)
        }
        
        if let processingInfoJson = value["processing_info"] {
            processingInfo = try? ProcessingInfo(json: processingInfoJson)
        }
        
        if (mediaId == nil) {
            mediaId = try? value.getString(at: "media_id_string")
        }
    }
    
    struct Image: JSONDecodable {
        
        var width: Int!
        var height: Int!
        var imageType: String!
        
        init(json value: JSON) throws {
            width = try value.getInt(at: "w")
            height = try value.getInt(at: "h")
            imageType = try? value.getString(at: "image_type")
        }
    
    }
    
    struct Video: JSONDecodable {
        
        var videoType: String!
        
        init(json value: JSON) throws {
            videoType = try? value.getString(at: "video_type")
        }
    }
    
    struct ProcessingInfo: JSONDecodable {
        
        var state: String!
        var checkAfterSecs: Int64!
        var progressPercent: Int!
//        var error: ErrorInfo!
        
        init(json value: JSON) throws {
            state = try? value.getString(at: "state")
            checkAfterSecs = try? value.decode(at: "check_after_secs")
            progressPercent = try? value.getInt(at: "progress_percent")
//            error <- map["error"]
        }
    }
    
    static let serialization = DataResponseSerializer<MediaUploadResponse> { (req, resp, data, err) -> Result<MediaUploadResponse> in
        if let data = data, let json = try? JSON(data: data) {
            if let response = try? MediaUploadResponse(json: json) , response.mediaId != nil {
                return .success(response)
            }
        }
        return .failure(MicroBlogError.decodeError)
    }
}
