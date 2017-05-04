//
//  MediaUploadResponse.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

// sourcery: jsonParse
class MediaUploadResponse {
    
    var mediaId: String!
    var size: Int64!
    var image: Image!
    var video: Video!
    var processingInfo: ProcessingInfo!
    
    required init() {

    }
    
    // sourcery: jsonParse
    class Image {
        
        var width: Int!
        var height: Int!
        var imageType: String!
        
        required init() {

        }
        
    }
    
    // sourcery: jsonParse
    class Video {
        
        var videoType: String!
        
        required init() {
            
        }
        
    }
    
    // sourcery: jsonParse
    class ProcessingInfo {
        
        var state: String!
        var checkAfterSecs: Int64!
        var progressPercent: Int!
//        var error: ErrorInfo!
        
        required init() {
        }
        
    }
    
}
