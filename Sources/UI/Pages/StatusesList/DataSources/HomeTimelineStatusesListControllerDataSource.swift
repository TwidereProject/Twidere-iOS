//
//  HomeTimelineStatusesListControllerDelegate.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/20.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit
import SQLite

class HomeTimelineStatusesListControllerDataSource: StatusesListControllerDataSource {
    
    let table = homeStatusesTable
    var statuses: [Status]? = nil
    
    func getAccounts() -> [Account] {
        return [try! defaultAccount()!]
    }
    
    func loadStatuses(_ opts: StatusesListController.LoadOptions) -> Promise<[Status]> {
        return DispatchQueue.global().promise { () -> [UserKey] in
            return self.getAccounts().map{ $0.key }
        }.then{ accountKeys -> Promise<[UserKey]> in
                return Promise { fullfill, reject in
                    if let params = opts.params , !opts.initLoad {
                        _ = GetStatusesTask.execute(params, table: self.table, fetchAction: { account, microblog, paging -> Promise<[Status]> in
                            return microblog.getHomeTimeline(paging)
                        }).always {
                            fullfill(accountKeys)
                        }
                    } else {
                        fullfill(accountKeys)
                    }
                }
        }.then { (accountKeys) -> [Status] in
                
                let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
                return try db.prepare(self.table.filter(accountKeys.contains(Status.RowIndices.accountKey)).order(Status.RowIndices.positionKey.desc)).map { row -> Status in
                    return Status(row: row)
                }
        }
    }
    
    func getNewestStatusIds(_ accounts: [Account]) -> [String?]? {
        let accountKeys = accounts.map { $0.key }
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        
        var result = [String?](repeating: nil, count: accounts.count)
        for row in try! db.prepare(table.select(Status.RowIndices.accountKey, Status.RowIndices.id)
            .group(Status.RowIndices.accountKey, having: accountKeys.contains(Status.RowIndices.accountKey))
            .order(Status.RowIndices.positionKey.max)) {
                if let key = row.get(Status.RowIndices.accountKey), let idx = accountKeys.index(where: {$0 == key}) {
                    result[idx] = row.get(Status.RowIndices.id)
                }
        }
        return result
    }
    
    func getNewestStatusSortIds(_ accounts: [Account]) -> [Int64]? {
        let accountKeys = accounts.map { $0.key }
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        
        var result = [Int64](repeating: -1, count: accounts.count)
        for row in try! db.prepare(table.select(Status.RowIndices.accountKey, Status.RowIndices.sortId)
            .group(Status.RowIndices.accountKey, having: accountKeys.contains(Status.RowIndices.accountKey))
            .order(Status.RowIndices.positionKey.max)) {
                if let key = row.get(Status.RowIndices.accountKey), let idx = accountKeys.index(where: {$0 == key}) {
                    result[idx] = row.get(Status.RowIndices.sortId) 
                }
        }
        return result
    }
    
}
    
