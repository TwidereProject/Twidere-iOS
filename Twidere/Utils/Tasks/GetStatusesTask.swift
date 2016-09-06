//
//  GetStatusesTask.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/5.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SQLite

class GetStatusesTask {
    
    static func execute(param: RefreshTaskParam, table: Table, fetchAction: (Account, MicroBlogService, Paging) throws -> [FlatStatus]) -> [StatusListResponse] {
        var result = [StatusListResponse]()
        
        let accounts = param.accounts
        let maxIds = param.maxIds
        let sinceIds = param.sinceIds
        let maxSortIds = param.maxSortIds
        let sinceSortIds = param.sinceSortIds
        
        let loadItemLimit = Defaults[.loadItemLimit] ?? defaultLoadItemLimit
        for (i, account) in accounts.enumerate() {
            let twitter = account.newMicroblogInstance()
            do {
                let paging = Paging()
                paging.count = loadItemLimit
                
                var maxSortId: Int64 = -1
                var sinceSortId: Int64 = -1
                let maxId = maxIds?[i]
                if (maxId != nil) {
                    paging.maxId = maxId!
                    maxSortId = maxSortIds?[i] ?? -1
                }
                
                let sinceId = sinceIds?[i]
                if (sinceId != nil) {
                    let sinceIdLong = Int64(sinceId!) ?? -1
                    //TODO handle non-twitter case
                    if (sinceIdLong != -1) {
                        paging.sinceId = String(sinceIdLong - 1)
                    } else {
                        paging.sinceId = String(sinceId)
                    }
                    sinceSortId = sinceSortIds?[i] ?? -1
                    if (maxId == nil) {
                        paging.latestResults = true
                    }
                }
                let statuses = try fetchAction(account, twitter, paging)
                try storeStatus(account, statuses: statuses, sinceId: sinceId, maxId: maxId, sinceSortId: sinceSortId, maxSortId: maxSortId, loadItemLimit: loadItemLimit, table: table, notify: false)
                // TODO cache related data and preload
                
            } catch let e {
                debugPrint(e)
                result.append(StatusListResponse(accountKey: UserKey(rawValue: account.accountKey!), error: e))
            }
        }
        return result
    }
    
    private static func storeStatus(account: Account, statuses: [FlatStatus], sinceId: String?, maxId: String?, sinceSortId: Int64, maxSortId: Int64, loadItemLimit: Int, table: Table, notify: Bool) throws {
        let accountKey = UserKey(rawValue: account.accountKey!)
        let db = (UIApplication.sharedApplication().delegate as! AppDelegate).sqliteDatabase
        
        let noItemsBefore = db.scalar(table.count) <= 0 // DataStoreUtils.getStatusCount(context, uri, accountKey) <= 0
        
        let statusIds = statuses.map({ $0.id! })
        var minIdx = -1
        var minPositionKey: Int64 = -1
        var hasIntersection = false
        if (!statuses.isEmpty) {
            let firstSortId = statuses.first!.sortId!
            let lastSortId = statuses.last!.sortId!
            // Get id diff of first and last item
            let sortDiff = firstSortId - lastSortId
            
            for (i, status) in statuses.enumerate() {
                status.positionKey = getPositionKey(status.createdAt, sortId: status.sortId, lastSortId: lastSortId, sortDiff: sortDiff, position: i, count: statuses.count)
                //                status.inserted_date = System.currentTimeMillis()
                if (minIdx == -1 || status < statuses[minIdx]) {
                    minIdx = i
                    minPositionKey = status.positionKey
                }
                if (sinceId != nil && status.sortId <= sinceSortId) {
                    hasIntersection = true
                }
            }
        }
        // Delete all rows conflicting before new data inserted.
        var olderCount = -1
        if (minPositionKey > 0) {
            olderCount = getStatusesCount(db, table: table, expression: FlatStatus.RowIndices.positionKey < minPositionKey, accountKeys: [accountKey])
        }
        
        let rowsDeleted = try db.run(table.filter(FlatStatus.RowIndices.accountKey == accountKey && statusIds.contains(FlatStatus.RowIndices.id)).delete())
        
        // Insert a gap.
        let deletedOldGap = rowsDeleted > 0 && statusIds.contains({$0 == maxId})
        let noRowsDeleted = rowsDeleted == 0
        // Why loadItemLimit / 2? because it will not acting strange in most cases
        let insertGap = minIdx != -1 && olderCount > 0 && (noRowsDeleted || deletedOldGap) && !noItemsBefore && !hasIntersection && statuses.count > loadItemLimit / 2
        if (insertGap) {
            statuses[minIdx].isGap = true
        }
        // Insert previously fetched items.
        try db.transaction {
            for status in statuses {
                try db.run(FlatStatus.insertData(table, model: status))
            }
        }
        
        if (maxId != nil && sinceId == nil) {
            try db.run(table.filter(FlatStatus.RowIndices.accountKey == accountKey && FlatStatus.RowIndices.id == maxId).update(FlatStatus.RowIndices.isGap <- true))
        }
    }
    
    static func getStatusesCount(db: Connection, table: Table, expression: Expression<Bool?>, accountKeys: [UserKey]) -> Int {
        return db.scalar(table.filter(expression).count)
    }
    
    
    static func getPositionKey(createdAt: NSDate, sortId: Int64, lastSortId: Int64, sortDiff: Int64, position: Int, count: Int) -> Int64 {
        if (sortDiff == 0) {
            return createdAt.timeIntervalSince1970Millis
        }
        let extraValue: Int
        if (sortDiff > 0) {
            // descent sorted by time
            extraValue = count - 1 - position
        } else {
            // ascent sorted by time
            extraValue = position
        }
        return createdAt.timeIntervalSince1970Millis + (sortId - lastSortId) * (499 - count) / sortDiff + extraValue
    }
    
    class StatusListResponse {
        let accountKey: UserKey
        
        var maxId: String? = nil
        var sinceId: String? = nil
        
        var truncated: Bool = false
        
        let statuses: [FlatStatus]!
        let error: ErrorType!
        
        init(accountKey: UserKey, statuses: [FlatStatus]) {
            self.accountKey = accountKey
            self.statuses = statuses
            self.error = nil
        }
        
        init(accountKey: UserKey, error: ErrorType) {
            self.accountKey = accountKey
            self.statuses = nil
            self.error = error
        }
    }
    
}