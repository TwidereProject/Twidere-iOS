// sourcery:jsonParse
public class OAuthCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=consumer_key
    public var consumer_key: String!
    // sourcery: jsonField=consumer_secret
    public var consumer_secret: String!
    
    // sourcery: jsonField=access_token
    public var access_token: String!
    // sourcery: jsonField=access_token_secret
    public var access_token_secret: String!
    
    // sourcery: jsonField=same_oauth_signing_url
    public var same_oauth_signing_url: Bool = false
    
    required public init() {
        
    }
    
}

// sourcery:jsonParse
public class OAuth2Credentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=access_token
    public var access_token: String!
    
    required public init() {
        
    }
}

// sourcery:jsonParse
public class BasicCredentials: AccountDetails.Credentials {
    
    // sourcery: jsonField=username
    public var username: String!
    // sourcery: jsonField=password
    public var password: String!
    
    required public init() {
        
    }
}

// sourcery:jsonParse
public class EmptyCredentials: AccountDetails.Credentials {
    
    required public init() {
        
    }
}
