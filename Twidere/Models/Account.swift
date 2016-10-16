// Automatically generated, DO NOT MODIFY
import Foundation
    
struct Account {

    // Fields
    var _id: Int64 = -1
    var key: UserKey
    var type: AccountType
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

    // Append body content

    // Sub models
    enum AccountType : String {
    
        // Fields
        case twitter
        case fanfou
        case statusNet
        // Append body content
    
    
    }
    struct Config {
    
        // Fields
        var characterLimit: Int
        var officialCredentials: Bool
        // Initializers
    
        // Append body content
    
        // Sub models
    
    }
}
