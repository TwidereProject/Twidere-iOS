//
//  Activity+MicroBlog.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Activity {
    convenience init?(_ json: JSON, accountKey: UserKey?) {
        guard let action = Activity.Action.parse(str: json["action"].stringValue) else {
            return nil
        }
        let createdAt = parseTwitterDate(json["created_at"].stringValue)!
        let sources = User.arrayFromJson(json["sources"], accountKey: accountKey)
        let sourceKeys = sources.map { $0.key }
        let targets = Activity.getTargets(action, json: json["targets"], accountKey: accountKey)
        let targetObjects = Activity.getTargetObjects(action, json: json["target_objects"], accountKey: accountKey)
        
        let minPosition = json["min_position"].stringValue
        let maxPosition = json["max_position"].stringValue
        
        let minSortPosition = Int64(minPosition) ?? createdAt.timeIntervalSince1970Millis
        let maxSortPosition = Int64(maxPosition) ?? createdAt.timeIntervalSince1970Millis
        
        self.init(accountKey: accountKey, createdAt: createdAt, maxSortPosition: maxSortPosition, minSortPosition: minSortPosition, maxPosition: maxPosition, minPosition: minPosition, action: action, sources: sources, sourceKeys: sourceKeys, targets: targets, targetObjects: targetObjects)
    }
    
    static func arrayFromJson(_ json: JSON, accountKey: UserKey?) -> [Activity] {
        if let array = json.array {
            return array.flatMap { Activity($0, accountKey: accountKey) }
        } else {
            return json["activities"].flatMap { Activity($1, accountKey: accountKey) }
        }
    }
    
    static func getTargets(_ action: Action, json: JSON, accountKey: UserKey?) -> Activity.ObjectList {
        let list = ObjectList()
        switch (action) {
        case .favorite, .reply, .retweet, .quote, .favoritedRetweet, .retweetedRetweet, .retweetedMention, .favoritedMention, .mediaTagged, .favoritedMediaTagged, .retweetedMediaTagged:
            list.statuses = Status.arrayFromJson(json, accountKey: accountKey)
        case .follow, .mention, .listMemberAdded:
            list.users = User.arrayFromJson(json, accountKey: accountKey)
        case .listCreated:
            break
        default:
            break
        }
        return list
    }
    
    static func getTargetObjects(_ action: Action, json: JSON, accountKey: UserKey?) -> Activity.ObjectList {
        let list = ObjectList()
        switch (action) {
        case .favorite, .follow, .mention, .reply, .retweet, .listCreated, .quote:
            list.statuses = Status.arrayFromJson(json, accountKey: accountKey)
        case .favoritedRetweet, .retweetedRetweet, .retweetedMention, .favoritedMention, .mediaTagged, .retweetedMediaTagged, .favoritedMediaTagged:
            list.users = User.arrayFromJson(json, accountKey: accountKey)
        case .listMemberAdded:
            break
        default:
            break
        }
        return list
    }
    
}

extension Activity.Action {
    static func parse(_ str: String) -> Activity.Action? {
        switch (str) {
        case "favorite": return .favorite
        case "follow": return .follow
        case "mention": return .mention
        case "reply": return .reply
        case "retweet": return .retweet
        case "list_member_added": return .listMemberAdded
        case "list_created": return .listCreated
        case "favorited_retweet": return .favoritedRetweet
        case "retweeted_retweet": return .retweetedRetweet
        case "quote": return .quote
        case "retweeted_mention": return .retweetedMention
        case "favorited_mention": return .favoritedMention
        case "joined_twitter": return .joinedTwitter
        case "media_tagged": return .mediaTagged
        case "favorited_media_tagged": return .favoritedMediaTagged
        case "retweeted_media_tagged": return .retweetedMediaTagged
        default: return nil
        }
    }
}
