//
//  ActivityExtension.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/9/29.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

func < (lhs: Activity, rhs: Activity) -> Bool {
    return lhs.createdAt < rhs.createdAt
}

func == (lhs: Activity, rhs: Activity) -> Bool {
    return lhs.accountKey == rhs.accountKey && lhs.createdAt == rhs.createdAt
}

extension Activity {
    
    var activityStatus: Status? {
        switch self.action! {
        case .mention:
            return targetObjects?.statuses?.first
        case .reply, .quote:
            return targets?.statuses?.first
        default:
            return nil
        }
    }
    
    func getTitleSummary() -> (String, String?) {
        switch self.action! {
        case .follow:
            return ("\(getSourcesName(self.sources.array)) followed you", nil)
        case .favorite:
            return ("\(getSourcesName(self.sources.array)) favorited your tweet", getTextOnlySummary(self.targets.statuses))
        case .retweet:
            return ("\(getSourcesName(self.sources.array)) retweeted your tweet", getTextOnlySummary(self.targetObjects.statuses))
        case .favoritedRetweet:
            return ("\(getSourcesName(self.sources.array)) favorited your retweet", getTextOnlySummary(self.targets.statuses))
        case .retweetedRetweet:
            return ("\(getSourcesName(self.sources.array)) retweeted your retweet", getTextOnlySummary(self.targets.statuses))
        case .favoritedMention:
            return ("\(getSourcesName(self.sources.array)) favorited a tweet you were mentioned in", getTextOnlySummary(self.targets.statuses))
        case .retweetedMention:
            return ("\(getSourcesName(self.sources.array)) retweeted a tweet you were mentioned in", getTextOnlySummary(self.targets.statuses))
        case .listMemberAdded:
            return ("\(getSourcesName(self.sources.array)) added you to their lists", nil)
        case .joinedTwitter:
            return ("\(getSourcesName(self.sources.array)) joined Twitter", nil)
        case .mediaTagged:
            return ("\(getSourcesName(self.sources.array)) tagged you", getTextOnlySummary(self.targets.statuses))
        case .favoritedMediaTagged:
            return ("\(getSourcesName(self.sources.array)) favorited a tweet you were tagged in", getTextOnlySummary(self.targets.statuses))
        case .retweetedMediaTagged:
            return ("\(getSourcesName(self.sources.array)) retweeted a tweet you were tagged in", getTextOnlySummary(self.targets.statuses))
        default:
            return (action.rawValue, "Message")
        }
    }
    
    private func getSourcesName(_ sources: [User]) -> String {
        if (sources.count > 2) {
            return "\(sources.first!.name!) and \(sources.count - 1) others"
        } else if (sources.count > 1) {
            return "\(sources[0].name!) and \(sources[1].name!)"
        } else {
            return sources.first!.name
        }
    }
    
    private func getTextOnlySummary(_ statuses: [Status]) -> String {
        var result = ""
        for status in statuses {
            result += status.textDisplay.replacingOccurrences(of: "\n", with: " ")
        }
        return result
    }
}
