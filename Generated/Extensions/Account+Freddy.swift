// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Account: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Account {
        let key: UserKey = try value.decode(at: "account_key")
        let type: AccountType = try value.decode(at: "account_type")
        let authType: AuthType = try value.decode(at: "auth_type")
        let credentials: Credentials = try value.decode(at: "credentials")
        let user: User = try value.decode(at: "user")
        let extras: Extras? = try value.decode(at: "extras", or: nil)
        return Account(key: key, type: type, authType: authType, credentials: credentials, user: user, extras: extras)
    }

}

extension Account: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["account_key"] = self.key.toJSON()
        dict["account_type"] = self.type.toJSON()
        dict["auth_type"] = self.authType.toJSON()
        dict["credentials"] = self.credentials.toJSON()
        dict["user"] = self.user.toJSON()
        if (extras != nil) {
            dict["extras"] = self.extras!.toJSON()
        }
        return .dictionary(dict)
    }
}

extension Account.AccountType: JSONDecodable, JSONEncodable {}
    

extension Account.AuthType: JSONDecodable, JSONEncodable {}
    
extension Account.Extras: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Account.Extras {
        let characterLimit: Int = try value.decode(at: "character_limit")
        let officialCredentials: Bool = try value.decode(at: "official_credentials")
        return Account.Extras(characterLimit: characterLimit, officialCredentials: officialCredentials)
    }

}

extension Account.Extras: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["character_limit"] = self.characterLimit.toJSON()
        dict["official_credentials"] = self.officialCredentials.toJSON()
        return .dictionary(dict)
    }
}

extension Account.Credentials: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> Account.Credentials {
        let apiUrlFormat: String = try value.decode(at: "api_url_format")
        let noVersionSuffix: Bool = try value.decode(at: "no_version_suffix")
        let consumerKey: String? = try? value.decode(at: "consumer_key")
        let consumerSecret: String? = try? value.decode(at: "consumer_secret")
        let accessToken: String? = try? value.decode(at: "oauth_token")
        let accessTokenSecret: String? = try? value.decode(at: "oauth_token_secret")
        let sameOAuthSigningUrl: Bool? = try? value.decode(at: "same_oauth_signing_url")
        let basicUsername: String? = try? value.decode(at: "username")
        let basicPassword: String? = try? value.decode(at: "password")
        return Account.Credentials(apiUrlFormat: apiUrlFormat, noVersionSuffix: noVersionSuffix, consumerKey: consumerKey, consumerSecret: consumerSecret, accessToken: accessToken, accessTokenSecret: accessTokenSecret, sameOAuthSigningUrl: sameOAuthSigningUrl, basicUsername: basicUsername, basicPassword: basicPassword)
    }

}

extension Account.Credentials: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["api_url_format"] = self.apiUrlFormat.toJSON()
        dict["no_version_suffix"] = self.noVersionSuffix.toJSON()
        if (consumerKey != nil) {
            dict["consumer_key"] = self.consumerKey!.toJSON()
        }
        if (consumerSecret != nil) {
            dict["consumer_secret"] = self.consumerSecret!.toJSON()
        }
        if (accessToken != nil) {
            dict["oauth_token"] = self.accessToken!.toJSON()
        }
        if (accessTokenSecret != nil) {
            dict["oauth_token_secret"] = self.accessTokenSecret!.toJSON()
        }
        if (sameOAuthSigningUrl != nil) {
            dict["same_oauth_signing_url"] = self.sameOAuthSigningUrl!.toJSON()
        }
        if (basicUsername != nil) {
            dict["username"] = self.basicUsername!.toJSON()
        }
        if (basicPassword != nil) {
            dict["password"] = self.basicPassword!.toJSON()
        }
        return .dictionary(dict)
    }
}

