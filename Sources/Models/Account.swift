// Automatically generated, DO NOT MODIFY
import Foundation

class Account {

    // Fields
    var _id: Int64 = -1
    var key: UserKey
    var type: AccountType
    var authType: AuthType
    var credentials: Credentials
    var user: User
    var extras: Extras? = nil
    // Initializers
    init(_id: Int64 = -1, key: UserKey, type: AccountType, authType: AuthType, credentials: Credentials, user: User, extras: Extras? = nil) {
        self._id = _id
        self.key = key
        self.type = type
        self.authType = authType
        self.credentials = credentials
        self.user = user
        self.extras = extras
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
    class Extras {
    
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
    class Credentials {
    
        // Fields
        var apiUrlFormat: String
        var noVersionSuffix: Bool
        var consumerKey: String!
        var consumerSecret: String!
        var accessToken: String!
        var accessTokenSecret: String!
        var sameOAuthSigningUrl: Bool!
        var basicUsername: String!
        var basicPassword: String!
        // Initializers
        init(apiUrlFormat: String, noVersionSuffix: Bool, consumerKey: String! = nil, consumerSecret: String! = nil, accessToken: String! = nil, accessTokenSecret: String! = nil, sameOAuthSigningUrl: Bool! = nil, basicUsername: String! = nil, basicPassword: String! = nil) {
            self.apiUrlFormat = apiUrlFormat
            self.noVersionSuffix = noVersionSuffix
            self.consumerKey = consumerKey
            self.consumerSecret = consumerSecret
            self.accessToken = accessToken
            self.accessTokenSecret = accessTokenSecret
            self.sameOAuthSigningUrl = sameOAuthSigningUrl
            self.basicUsername = basicUsername
            self.basicPassword = basicPassword
        }
        // Append body content
    
        // Sub models
    
    }
}
