// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension Account: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self._id = nil
        self.key = try? value.decode(at: "account_key")
        self.type = try? value.decode(at: "account_type")
        self.apiUrlFormat = try? value.decode(at: "api_url_format")
        self.authType = try? value.decode(at: "auth_type")
        self.basicPassword = try? value.decode(at: "basic_password")
        self.basicUsername = try? value.decode(at: "basic_username")
        self.consumerKey = try? value.decode(at: "consumer_key")
        self.consumerSecret = try? value.decode(at: "consumer_secret")
        self.noVersionSuffix = try? value.decode(at: "no_version_suffix")
        self.oauthToken = try? value.decode(at: "oauth_token")
        self.oauthTokenSecret = try? value.decode(at: "oauth_token_secret")
        self.sameOAuthSigningUrl = try? value.decode(at: "same_oauth_signing_url")
        self.config = try? value.decode(at: "config")
        self.user = try? value.decode(at: "user")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [

        ]
        return .dictionary(dict)
    }
}

extension Account.Config: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.characterLimit = try? value.decode(at: "character_limit")
        self.officialCredentials = try? value.decode(at: "official_credentials")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [

        ]
        return .dictionary(dict)
    }
}


