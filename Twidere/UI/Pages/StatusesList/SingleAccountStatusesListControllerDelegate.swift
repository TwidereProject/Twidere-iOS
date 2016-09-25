//
//  UserTimelineStatusesListControllerDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit

class SingleAccountStatusesListControllerDelegate: StatusesListControllerDelegate {
    
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    final func getAccounts() -> [Account] {
        return [account]
    }
    
    final func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[Status]> {
        let microBlog = self.account.newMicroBlogService("api")
        var paging = Paging()
        return getStatusesRequest(microBlog: microBlog, paging: paging)
    }
    
    final func getNewestStatusIds(_ accounts: [Account]) -> [String?]? {
        return nil
    }
    
    final func getNewestStatusSortIds(_ accounts: [Account]) -> [Int64]? {
        return nil
    }
    
    func getStatusesRequest(microBlog: MicroBlogService, paging: Paging) -> Promise<[Status]> {
        fatalError("Abstract function")
    }
}
