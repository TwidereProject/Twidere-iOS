//
//  UserTimelineStatusesListControllerDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit

class SingleAccountStatusesListControllerDataSource: StatusesListControllerDataSource {
    
    var account: Account
    var statuses: [Status]? = nil
    
    init(account: Account) {
        self.account = account
    }
    
    final func getAccounts() -> [Account] {
        return [account]
    }
    
    final func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[Status]> {
        let microBlog = self.account.newMicroBlogService("api")
        let paging = Paging()
        let loadingMore = opts.params?.isLoadingMore ?? false
        let loadItemLimit = opts.loadItemLimit
        if let maxId = opts.params?.maxIds?.first {
            paging.maxId = maxId
        }
        if let sinceId = opts.params?.sinceIds?.first {
            paging.sinceId = sinceId
        }
        
        return getStatusesRequest(microBlog: microBlog, paging: paging).then(on: DispatchQueue.global()) { fetched -> [Status] in
            var rowsDeleted: Int = 0
            
            let noItemsBefore = self.statuses?.isEmpty ?? true
            // Filter out statuses found in fetched list
            var result: [Status] = self.statuses?.filter { status -> Bool in
                if (fetched.contains(where: { $0.id == status.id })) {
                    rowsDeleted += 1
                    return false
                }
                return true
            } ?? []
            let deletedOldGap = rowsDeleted > 0 && fetched.contains(where: { $0.id == paging.maxId })
            let noRowsDeleted = rowsDeleted == 0
            fetched.min(by: >)?.isGap = (noRowsDeleted || deletedOldGap) && !noItemsBefore && fetched.count >= loadItemLimit && !loadingMore
            result.append(contentsOf: fetched)
            result.sort(by: >)
            return result
        }
    }
    
    final func getNewestStatusIds(_ accounts: [Account]) -> [String?]? {
        return [self.statuses?.min(by: >)?.id]
    }
    
    final func getNewestStatusSortIds(_ accounts: [Account]) -> [Int64]? {
        return [self.statuses?.min(by: >)?.sortId ?? -1]
    }
    
    func getStatusesRequest(microBlog: MicroBlogService, paging: Paging) -> Promise<[Status]> {
        fatalError("Abstract function")
    }
}
