// Automatically generated, DO NOT MODIFY
import Foundation

class Account {

    // Fields
    var _id: Int64 = -1
    var key: UserKey
    var type: String
    var apiUrlFormat: String
    var authType: String
    var basicPassword: String?
    var basicUsername: String?
    var consumerKey: String?
    var consumerSecret: String?
    var noVersionSuffix: Bool
    var oauthToken: String?
    var oauthTokenSecret: String?
    var sameOAuthSigningUrl: Bool
    var config: Config? = nil
    var user: User
    // Initializers
 init(_id: Int64 = -1, key: UserKey, type: String, apiUrlFormat: String, authType: String, basicPassword: String?, basicUsername: String?, consumerKey: String?, consumerSecret: String?, noVersionSuffix: Bool, oauthToken: String?, oauthTokenSecret: String?, sameOAuthSigningUrl: Bool, config: Config? = nil, user: User) {
self._id = _id
self.key = key
self.type = type
self.apiUrlFormat = apiUrlFormat
self.authType = authType
self.basicPassword = basicPassword
self.basicUsername = basicUsername
self.consumerKey = consumerKey
self.consumerSecret = consumerSecret
self.noVersionSuffix = noVersionSuffix
self.oauthToken = oauthToken
self.oauthTokenSecret = oauthTokenSecret
self.sameOAuthSigningUrl = sameOAuthSigningUrl
self.config = config
self.user = user
}
    // Append body content

    // Sub models
    enum AccountType {
    
        // Fields
        case twitter
        case fanfou
        case statusNet
        // Append body content
    
    
    }
    class Config {
    
        // Fields
        var characterLimit: Int
        var officialCredentials: Bool
        // Initializers
     init(characterLimit: Int, officialCredentials: Bool) {
    self.characterLimit = characterLimit
    self.officialCredentials = officialCredentials
    }
        // Append body content
    
        // Sub models
    
    
    }

}
