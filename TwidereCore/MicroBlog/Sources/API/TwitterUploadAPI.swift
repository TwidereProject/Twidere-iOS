//
//  TwitterUploadService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/4.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import PromiseKit

// sourcery: restProtocol
// sourcery: extraImports=RestCommons
public protocol TwitterUploadAPI {
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/media/upload.json
    // sourcery: restSerializer=MediaUploadResponseJsonMapper.singleton.responseSerializer
    // sourcery: restParams=command%3DINIT
    func initUploadMedia(/* sourcery: param=media_type */mediaType: String, /* sourcery: restParam=total_bytes */totalBytes: Int, /* sourcery: param=additional_owners */additionalOwners: [String]?) -> Promise<MediaUploadResponse>
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/media/upload.json
    // sourcery: restSerializer=StatusCodeResponseSerializer
    // sourcery: restParams=command%3DAPPEND
    func appendUploadMedia(/* sourcery: param=media_id */id: String, /* sourcery: param=segment_index */segmentIndex: Int, /* sourcery: param=media */media: Data) -> Promise<Int>
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/media/upload.json
    // sourcery: restSerializer=MediaUploadResponseJsonMapper.singleton.responseSerializer
    // sourcery: restParams=command%3DFINALIZE
    func finalizeUploadMedia(/* sourcery: param=media_id */id: String) -> Promise<MediaUploadResponse>
    
    
    // sourcery: restMethod=POST
    // sourcery: restPath=/media/upload.json
    // sourcery: restSerializer=MediaUploadResponseJsonMapper.singleton.responseSerializer
    // sourcery: restParams=command%3DSTATUS
    func getUploadMediaStatus(/* sourcery: param=media_id */id: String) -> Promise<MediaUploadResponse>
}
