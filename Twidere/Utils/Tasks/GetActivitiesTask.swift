//
//  GetActivitiesTask.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/30.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import SQLite
import PromiseKit

class GetActivitiesTask {
    
    static func execute(_ param: RefreshTaskParam, table: Table, fetchAction: @escaping (Account, MicroBlogService, Paging) -> Promise<[Activity]>) -> Promise<[ActivityListResponse]> {
        
        let accounts = param.accounts
        let maxIds = param.maxIds
        let sinceIds = param.sinceIds
        let maxSortIds = param.maxSortIds
        let sinceSortIds = param.sinceSortIds
        
        let loadItemLimit = Defaults[.loadItemLimit] ?? defaultLoadItemLimit
        var saveReadPosition = false
        
        // Try to fetch for all accounts, continue even there are rejected tasks
        return when(fulfilled: accounts.enumerated().map { (i, account) -> Promise<ActivityListResponse> in
            let twitter = account.newMicroBlogService()
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
                    paging.sinceId = String(describing: sinceId)
                }
                sinceSortId = sinceSortIds?[i] ?? -1
                if (maxId == nil) {
                    paging.latestResults = true
                    saveReadPosition = true
                }
            }
            return Promise<ActivityListResponse> { fullfill, reject in
                fetchAction(account, twitter, paging).then(on: .global()) { activities -> [Activity] in
                    try storeActivities(account, activities: activities, sinceId: sinceId, maxId: maxId, sinceSortId: sinceSortId, maxSortId: maxSortId, loadItemLimit: loadItemLimit, table: table, notify: false)
                    
                    // TODO cache related data and preload
                    return activities
                }.then { activities -> Void in
                    fullfill(ActivityListResponse(accountKey: account.key, activities: activities))
                }.catch { error in
                    debugPrint(error)
                    fullfill(ActivityListResponse(accountKey: account.key, error: error))
                }
            }
        })
    }
    
    fileprivate static func storeActivities(_ account: Account, activities: [Activity], sinceId: String?, maxId: String?, sinceSortId: Int64, maxSortId: Int64, loadItemLimit: Int, table: Table, notify: Bool) throws {
        let accountKey = account.key!
        let db = (UIApplication.shared.delegate as! AppDelegate).sqliteDatabase
        
        let noItemsBefore = try db.scalar(table.filter(accountKey == Activity.RowIndices.accountKey).count) <= 0
        
        var deleteBound: [Int64] = [-1, -1]
        var minIdx = -1
        var minPositionKey: Int64 = -1
        if (!activities.isEmpty) {
            let firstSortId = activities.first!.createdAt.timeIntervalSince1970Millis
            let lastSortId = activities.last!.createdAt.timeIntervalSince1970Millis
            // Get id diff of first and last item
            let sortDiff = firstSortId - lastSortId
            
            for i in 0..<activities.count {
                let activity = activities[i]
                activity.positionKey = getPositionKey(activity.createdAt as Date, sortId: activity.createdAt.timeIntervalSince1970Millis, lastSortId: lastSortId, sortDiff: sortDiff, position: i, count: activities.count)
                
                if (deleteBound[0] < 0) {
                    deleteBound[0] = activity.minSortPosition
                } else {
                    deleteBound[0] = min(deleteBound[0], activity.minSortPosition)
                }
                if (deleteBound[1] < 0) {
                    deleteBound[1] = activity.maxSortPosition
                } else {
                    deleteBound[1] = max(deleteBound[1], activity.maxSortPosition)
                }
                if (minIdx == -1 || activity < activities[minIdx]) {
                    minIdx = i
                    minPositionKey = activity.positionKey
                }
            }
        }
        // Delete all rows conflicting before new data inserted.
        var olderCount = -1
        if (minPositionKey > 0) {
            olderCount = try db.scalar(table.filter(Activity.RowIndices.positionKey < minPositionKey && accountKey == Activity.RowIndices.accountKey).count)
        }
        
        if (deleteBound[0] > 0 && deleteBound[1] > 0) {
            let rowsDeleted = try db.run(table.filter(Activity.RowIndices.accountKey == accountKey && Activity.RowIndices.minSortPosition >= deleteBound[0] && Activity.RowIndices.maxSortPosition <= deleteBound[1]).delete())
            
            // Why loadItemLimit / 2? because it will not acting strange in most cases
            let insertGap = !noItemsBefore && olderCount > 0 && rowsDeleted <= 0 && activities.count > loadItemLimit / 2
            if (insertGap) {
                activities[minIdx].isGap = true
            }
        }
        // Insert previously fetched items.
        try db.transaction {
            for activity in activities {
                _ = try db.run(Activity.insertData(table: table, model: activity))
            }
        }
        
        // Remove gap flag
        if (maxId != nil && sinceId == nil) {
            _ = try db.run(table.filter(Activity.RowIndices.accountKey == accountKey && Activity.RowIndices.minPosition == maxId && Activity.RowIndices.maxPosition == maxId).update(Activity.RowIndices.isGap <- false))
        }
    }
    
    static func getPositionKey(_ createdAt: Date, sortId: Int64, lastSortId: Int64, sortDiff: Int64, position: Int, count: Int) -> Int64 {
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
    
    class ActivityListResponse {
        let accountKey: UserKey
        
        var maxId: String? = nil
        var sinceId: String? = nil
        
        var truncated: Bool = false
        
        let activities: [Activity]!
        let error: Error!
        
        init(accountKey: UserKey, activities: [Activity]) {
            self.accountKey = accountKey
            self.activities = activities
            self.error = nil
        }
        
        init(accountKey: UserKey, error: Error) {
            self.accountKey = accountKey
            self.activities = nil
            self.error = error
        }
    }
    
}
