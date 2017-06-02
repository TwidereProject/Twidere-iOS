//
//  UserTimelineStatusesListControllerDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit
import TwidereCore

class UserTimelineStatusesListControllerDataSource: SingleAccountStatusesListControllerDataSource {
    
    var userKey: UserKey?
    var screenName: String?
    
    init(account: AccountDetails, userKey: UserKey?, screenName: String?) {
        self.userKey = userKey
        self.screenName = screenName
        super.init(account: account)
    }
    
    override func getStatusesRequest(microBlog: MicroBlogService, paging: Paging) -> Promise<[PeristableStatus]> {
        if let userKey = self.userKey {
            return microBlog.getUserTimeline(id: userKey.id, paging: paging)
        } else if let screenName = self.screenName {
            return microBlog.getUserTimeline(screenName: screenName, paging: paging)
        }
        return Promise(error: MicroBlogError.argumentError(message: "Invalid parameter"))
    }
}
