//
//  Attachment.swift
//  Mastodon
//
//  Created by Mariotaku Lee on 2017/6/8.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import Foundation

// sourcery: jsonParse
public class Attachment {
    /**
     * ID of the attachment
     */
    //sourcery: jsonField=id
    var id: String!
    /**
     * One of: `image`, `video`, `gifv`
     */
    //sourcery: jsonField=type
    var type: String!
    /**
     * URL of the locally hosted version of the image
     */
    //sourcery: jsonField=url
    var url: String!
    /**
     * For remote images, the remote URL of the original image
     */
    //sourcery: jsonField=remote_url
    var remoteUrl: String!
    /**
     * URL of the preview image
     */
    //sourcery: jsonField=preview_url
    var previewUrl: String!
    /**
     * Shorter URL for the image, for insertion into text (only present on local images)
     */
    //sourcery: jsonField=text_url
    var textUrl: String!

    required public init() {
        
    }
}
