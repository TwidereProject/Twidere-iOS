//
//  MediaUploadResponse.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

// sourcery: jsonParse
public class MediaUploadResponse {
    
    public internal(set) var mediaId: String!
    public internal(set) var size: Int64!
    public internal(set) var image: Image!
    public internal(set) var video: Video!
    public internal(set) var processingInfo: ProcessingInfo!
    
    required public init() {

    }
    
    // sourcery: jsonParse
    public class Image {
        
        var width: Int!
        var height: Int!
        var imageType: String!
        
        required public init() {

        }
        
    }
    
    // sourcery: jsonParse
    public class Video {
        
        var videoType: String!
        
        required public init() {
            
        }
        
    }
    
    // sourcery: jsonParse
    public class ProcessingInfo {
        
        var state: String!
        var checkAfterSecs: Int64!
        var progressPercent: Int!
//        var error: ErrorInfo!
        
        required public init() {
        }
        
    }
    
}
