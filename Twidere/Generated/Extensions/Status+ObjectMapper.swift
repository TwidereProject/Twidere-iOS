// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension Status: StaticMappable {

    func mapping(map: Map) {
        _id <- map["_id"]
        accountKey <- map["accountKey"]
        sortId <- map["sortId"]
        positionKey <- map["positionKey"]
        isGap <- map["isGap"]
        createdAt <- map["createdAt"]
        id <- map["id"]
        userKey <- map["userKey"]
        userName <- map["userName"]
        userScreenName <- map["userScreenName"]
        userProfileImage <- map["userProfileImage"]
        textPlain <- map["textPlain"]
        textDisplay <- map["textDisplay"]
        metadata <- map["metadata"]
        quotedId <- map["quotedId"]
        quotedUserKey <- map["quotedUserKey"]
        quotedUserName <- map["quotedUserName"]
        quotedUserScreenName <- map["quotedUserScreenName"]
        quotedUserProfileImage <- map["quotedUserProfileImage"]
        quotedTextPlain <- map["quotedTextPlain"]
        quotedTextDisplay <- map["quotedTextDisplay"]
        quotedMetadata <- map["quotedMetadata"]
        retweetedByUserKey <- map["retweetedByUserKey"]
        retweetedByUserName <- map["retweetedByUserName"]
        retweetedByUserScreenName <- map["retweetedByUserScreenName"]
        retweetedByUserProfileImage <- map["retweetedByUserProfileImage"]
        retweetId <- map["retweetId"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Status()
    }
}

extension Status.Metadata: StaticMappable {

    func mapping(map: Map) {
        links <- map["links"]
        mentions <- map["mentions"]
        hashtags <- map["hashtags"]
        media <- map["media"]
        displayRange <- map["displayRange"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Status.Metadata()
    }
}


