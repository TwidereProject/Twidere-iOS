// Automatically generated, DO NOT MODIFY
import Foundation

class Account {

    // Fields
    var _id: Int64 = -1
    var key: UserKey
    var type: AccountType
    var apiUrlFormat: String
    var authType: AuthType
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
    init(_id: Int64 = -1, key: UserKey, type: AccountType, apiUrlFormat: String, authType: AuthType, basicPassword: String?, basicUsername: String?, consumerKey: String?, consumerSecret: String?, noVersionSuffix: Bool, oauthToken: String?, oauthTokenSecret: String?, sameOAuthSigningUrl: Bool, config: Config? = nil, user: User) {
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
    
    enum AccountType : String {
    
        // Fields
        case twitter
        case fanfou
        case statusNet
    
        var rawValue: String {
            switch self {
            case .twitter: return "twitter"
            case .fanfou: return "fanfou"
            case .statusNet: return "statusnet"
            }
        }
    
        init?(rawValue: String) {
            switch rawValue {
            case "twitter": self = .twitter
            case "fanfou": self = .fanfou
            case "statusnet": self = .statusNet
            default: return nil
            }
        }
            
        // Append body content
    
    
    }
    
    enum AuthType : String {
    
        // Fields
        case oauth
        case xAuth
        case basic
        case empty
    
        var rawValue: String {
            switch self {
            case .oauth: return "oauth"
            case .xAuth: return "xauth"
            case .basic: return "basic"
            case .empty: return "empty"
            }
        }
    
        init?(rawValue: String) {
            switch rawValue {
            case "oauth": self = .oauth
            case "xauth": self = .xAuth
            case "basic": self = .basic
            case "empty": self = .empty
            default: return nil
            }
        }
            
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
