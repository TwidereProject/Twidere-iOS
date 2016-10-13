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
    var config: Config? 
    var user: User 
    // Append body content
 enum AccountType: String { case twitter, fanfou, statusNet } 
    // Sub models
    struct Config {
    
        // Fields
        var characterLimit: Int 
        var officialCredentials: Bool 
        // Append body content
    
        // Sub models
    
    
    }

}
