//
//  PersistableStatusExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

public extension PersistableStatus {
    
    func addFilterFlag(_ flag : PersistableStatus.FilterFlag) {
        filter_flags = filter_flags.union(flag)
    }
    
    public var quoted: PersistableStatus! {
        if (quoted_id == nil || quoted_user_key == nil) {
            return nil
        }
        let obj = PersistableStatus()
        obj.account_key = account_key
        obj.id = quoted_id
        obj.timestamp = quoted_timestamp
        obj.user_key = quoted_user_key
        obj.user_name = quoted_user_name
        obj.user_screen_name = quoted_user_screen_name
        obj.user_profile_image_url = quoted_user_profile_image
        obj.user_is_protected = quoted_user_is_protected
        obj.user_is_verified = quoted_user_is_verified
        obj.text_plain = quoted_text_plain
        obj.text_unescaped = quoted_text_unescaped
        obj.source = quoted_source
        obj.spans = quoted_spans
        obj.media = quoted_media
        return obj
    }
}
