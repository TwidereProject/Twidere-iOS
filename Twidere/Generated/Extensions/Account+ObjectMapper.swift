// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension Account: StaticMappable {

    func mapping(_ map: Map) {
        key <- (map["account_key"], UserKeyTransform())
        type <- map["account_type"]
        apiUrlFormat <- map["api_url_format"]
        authType <- map["auth_type"]
        basicPassword <- map["basic_password"]
        basicUsername <- map["basic_username"]
        consumerKey <- map["consumer_key"]
        consumerSecret <- map["consumer_secret"]
        noVersionSuffix <- map["no_version_suffix"]
        oauthToken <- map["oauth_token"]
        oauthTokenSecret <- map["oauth_token_secret"]
        sameOAuthSigningUrl <- map["same_oauth_signing_url"]
        config <- map["config"]
        user <- map["user"]
    }

    static func objectForMapping(_ map: Map) -> BaseMappable? {
        return Account()
    }
}

extension Account.Config: StaticMappable {

    func mapping(_ map: Map) {
        characterLimit <- map["character_limit"]
    }

    static func objectForMapping(_ map: Map) -> BaseMappable? {
        return Account.Config()
    }
}


