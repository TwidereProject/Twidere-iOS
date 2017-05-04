// sourcery:jsonParse
public class OAuthCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=consumer_key
    var consumer_key: String!
    // sourcery: jsonField=consumer_secret
    var consumer_secret: String!
    
    // sourcery: jsonField=access_token
    var access_token: String!
    // sourcery: jsonField=access_token_secret
    var access_token_secret: String!
    
    // sourcery: jsonField=same_oauth_signing_url
    var same_oauth_signing_url: Bool = false
    
    required public init() {
        
    }
    
}

// sourcery:jsonParse
public class OAuth2Credentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=access_token
    var access_token: String!
    
    required public init() {
        
    }
}

// sourcery:jsonParse
public class BasicCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=username
    var username: String!
    // sourcery: jsonField=password
    var password: String!
    
    required public init() {
        
    }
}

// sourcery:jsonParse
public class EmptyCredentials: AccountDetails.Credentials {
    
    required public init() {
        
    }
}
