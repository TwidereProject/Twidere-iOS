// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Account: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> Account {
        var obj = Account()
        obj._id = -1
        let key: UserKey = try value.decode(at: "account_key")
        let type: String = try value.decode(at: "account_type")
        let apiUrlFormat: String = try value.decode(at: "api_url_format")
        let authType: String = try value.decode(at: "auth_type")
        let basicPassword: String = try value.decode(at: "basic_password")
        let basicUsername: String = try value.decode(at: "basic_username")
        let consumerKey: String = try value.decode(at: "consumer_key")
        let consumerSecret: String = try value.decode(at: "consumer_secret")
        let noVersionSuffix: Bool = try value.decode(at: "no_version_suffix")
        let oauthToken: String = try value.decode(at: "oauth_token")
        let oauthTokenSecret: String = try value.decode(at: "oauth_token_secret")
        let sameOAuthSigningUrl: Bool = try value.decode(at: "same_oauth_signing_url")
        let config: Config = try value.decode(at: "config")
        let user: User = try value.decode(at: "user")
        return obj
    }

}

extension Account: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension Account.AccountType: JSONDecodable, JSONEncodable {}
    
extension Account.Config: JSONDecodable {

    init(json value: JSON) throws {
        self.characterLimit = try value.decode(at: "character_limit")
        self.officialCredentials = try value.decode(at: "official_credentials")
    }

}

extension Account.Config: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

