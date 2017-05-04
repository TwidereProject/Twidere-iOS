//
//  InteractionsActivitiesListControllerDataSource.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import PromiseKit
import SQLite

class InteractionsActivitiesListControllerDataSource: ActivitiesListControllerDataSource {
    
    let table = interactionsTable
    
    func getAccounts() -> [Account] {
        return [try! defaultAccount()!]
    }
    
    func loadActivities(_ opts: ActivitiesListController.LoadOptions) -> Promise<[Activity]> {
        return DispatchQueue.global().promise { () -> [UserKey] in
            return self.getAccounts().map { $0.key }
        }.then{ accountKeys -> Promise<[UserKey]> in
                return Promise { fullfill, reject in
                    if let params = opts.params , !opts.initLoad {
                        _ = GetActivitiesTask.execute(params, table: self.table, fetchAction: { account, microblog, paging -> Promise<[Activity]> in
                            return microblog.getActivitiesAboutMe(paging: paging)
                        }).always {
                            fullfill(accountKeys)
                        }
                    } else {
                        fullfill(accountKeys)
                    }
                }
            }.then { (accountKeys) -> [Activity] in
                let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
                return try db.prepare(self.table.filter(accountKeys.contains(Activity.RowIndices.accountKey)).order(Activity.RowIndices.positionKey.desc)).map {
                    Activity(row: $0)
                }
        }
    }
    
    func getNewestActivityMaxPositions(_ accounts: [Account]) -> [String?]? {
        let accountKeys = accounts.map { $0.key }
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        
        var result = [String?](repeating: nil, count: accounts.count)
        for row in try! db.prepare(table.select(Activity.RowIndices.accountKey, Activity.RowIndices.maxPosition)
            .group(Activity.RowIndices.accountKey, having: accountKeys.contains(Activity.RowIndices.accountKey))
            .order(Activity.RowIndices.positionKey.max)) {
                if let key = row.get(Activity.RowIndices.accountKey), let idx = accountKeys.index(where: {$0 == key}) {
                    result[idx] = row.get(Activity.RowIndices.maxPosition)
                }
        }
        return result
    }
    
    func getNewestActivityMaxSortPositions(_ accounts: [Account]) -> [Int64]? {
        let accountKeys = accounts.map { $0.key }
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        
        var result = [Int64](repeating: -1, count: accounts.count)
        for row in try! db.prepare(table.select(Activity.RowIndices.accountKey, Activity.RowIndices.maxSortPosition)
            .group(Activity.RowIndices.accountKey, having: accountKeys.contains(Activity.RowIndices.accountKey))
            .order(Activity.RowIndices.positionKey.max)) {
                if let key = row.get(Activity.RowIndices.accountKey), let idx = accountKeys.index(where: {$0 == key}) {
                    result[idx] = row.get(Activity.RowIndices.maxSortPosition) 
                }
        }
        return result
    }
    
}
