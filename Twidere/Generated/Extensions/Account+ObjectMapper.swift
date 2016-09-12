// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension Account: StaticMappable {

    func mapping(map: Map) {
        _id <- map["_id"]
        key <- map["key"]
        type <- map["type"]
        apiUrlFormat <- map["apiUrlFormat"]
        authType <- map["authType"]
        basicPassword <- map["basicPassword"]
        basicUsername <- map["basicUsername"]
        consumerKey <- map["consumerKey"]
        consumerSecret <- map["consumerSecret"]
        noVersionSuffix <- map["noVersionSuffix"]
        oauthToken <- map["oauthToken"]
        oauthTokenSecret <- map["oauthTokenSecret"]
        sameOAuthSigningUrl <- map["sameOAuthSigningUrl"]
        config <- map["config"]
        user <- map["user"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Account()
    }
}

extension Account.Config: StaticMappable {

    func mapping(map: Map) {
        characterLimit <- map["characterLimit"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return Account.Config()
    }
}


