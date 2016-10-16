// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Account: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Account {
        let key: UserKey = try value.decode(at: "account_key")
        let type: AccountType = try value.decode(at: "account_type")
        let apiUrlFormat: String = try value.decode(at: "api_url_format")
        let authType: AuthType = try value.decode(at: "auth_type")
        let basicPassword: String? = try? value.decode(at: "basic_password")
        let basicUsername: String? = try? value.decode(at: "basic_username")
        let consumerKey: String? = try? value.decode(at: "consumer_key")
        let consumerSecret: String? = try? value.decode(at: "consumer_secret")
        let noVersionSuffix: Bool = try value.decode(at: "no_version_suffix")
        let oauthToken: String? = try? value.decode(at: "oauth_token")
        let oauthTokenSecret: String? = try? value.decode(at: "oauth_token_secret")
        let sameOAuthSigningUrl: Bool = try value.decode(at: "same_oauth_signing_url")
        let config: Config? = try? value.decode(at: "config")
        let user: User = try value.decode(at: "user")
        return Account(key: key, type: type, apiUrlFormat: apiUrlFormat, authType: authType, basicPassword: basicPassword, basicUsername: basicUsername, consumerKey: consumerKey, consumerSecret: consumerSecret, noVersionSuffix: noVersionSuffix, oauthToken: oauthToken, oauthTokenSecret: oauthTokenSecret, sameOAuthSigningUrl: sameOAuthSigningUrl, config: config, user: user)
    }

}

extension Account: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["account_key"] = self.key.toJSON()
        dict["account_type"] = self.type.toJSON()
        dict["api_url_format"] = self.apiUrlFormat.toJSON()
        dict["auth_type"] = self.authType.toJSON()
        if (basicPassword != nil) {
            dict["basic_password"] = self.basicPassword!.toJSON()
        }
        if (basicUsername != nil) {
            dict["basic_username"] = self.basicUsername!.toJSON()
        }
        if (consumerKey != nil) {
            dict["consumer_key"] = self.consumerKey!.toJSON()
        }
        if (consumerSecret != nil) {
            dict["consumer_secret"] = self.consumerSecret!.toJSON()
        }
        dict["no_version_suffix"] = self.noVersionSuffix.toJSON()
        if (oauthToken != nil) {
            dict["oauth_token"] = self.oauthToken!.toJSON()
        }
        if (oauthTokenSecret != nil) {
            dict["oauth_token_secret"] = self.oauthTokenSecret!.toJSON()
        }
        dict["same_oauth_signing_url"] = self.sameOAuthSigningUrl.toJSON()
        if (config != nil) {
            dict["config"] = self.config!.toJSON()
        }
        dict["user"] = self.user.toJSON()
        return .dictionary(dict)
    }
}

extension Account.AccountType: JSONDecodable, JSONEncodable {}
    

extension Account.AuthType: JSONDecodable, JSONEncodable {}
    
extension Account.Config: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Account.Config {
        let characterLimit: Int = try value.decode(at: "character_limit")
        let officialCredentials: Bool = try value.decode(at: "official_credentials")
        return Account.Config(characterLimit: characterLimit, officialCredentials: officialCredentials)
    }

}

extension Account.Config: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["character_limit"] = self.characterLimit.toJSON()
        dict["official_credentials"] = self.officialCredentials.toJSON()
        return .dictionary(dict)
    }
}

