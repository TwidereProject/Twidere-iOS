//
//  TwitterMentionEntityExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import MicroBlog

extension UserMentionEntity {
    
    func toPersistable(_ host: String?) -> MentionItem {
        let obj = MentionItem()
        obj.key = UserKey(id: id, host: host)
        obj.name = name
        obj.screen_name = screenName
        return obj
    }

}
