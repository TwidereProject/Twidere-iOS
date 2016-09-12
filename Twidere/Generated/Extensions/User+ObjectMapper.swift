// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension User: StaticMappable {

    func mapping(map: Map) {
        _id <- map["_id"]
        accountKey <- map["accountKey"]
        key <- map["key"]
        createdAt <- map["createdAt"]
        position <- map["position"]
        isProtected <- map["isProtected"]
        isVerified <- map["isVerified"]
        name <- map["name"]
        screenName <- map["screenName"]
        profileImageUrl <- map["profileImageUrl"]
        profileBannerUrl <- map["profileBannerUrl"]
        profileBackgroundUrl <- map["profileBackgroundUrl"]
        descriptionPlain <- map["descriptionPlain"]
        descriptionDisplay <- map["descriptionDisplay"]
        url <- map["url"]
        urlExpanded <- map["urlExpanded"]
        location <- map["location"]
        metadata <- map["metadata"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return User()
    }
}

extension User.Metadata: StaticMappable {

    func mapping(map: Map) {
        following <- map["following"]
        followedBy <- map["followedBy"]
        blocking <- map["blocking"]
        blockedBy <- map["blockedBy"]
        muting <- map["muting"]
        followRequestSent <- map["followRequestSent"]
        statusesCount <- map["statusesCount"]
        followersCount <- map["followersCount"]
        friendsCount <- map["friendsCount"]
        favoritesCount <- map["favoritesCount"]
        mediaCount <- map["mediaCount"]
        listsCount <- map["listsCount"]
        listedCount <- map["listedCount"]
        groupsCount <- map["groupsCount"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return User.Metadata()
    }
}


