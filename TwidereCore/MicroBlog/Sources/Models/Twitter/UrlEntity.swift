// sourcery: jsonParse
public class UrlEntity {
    
    // sourcery: jsonField=url
    public var url: String!
    // sourcery: jsonField=display_url
    public var displayUrl: String!
    // sourcery: jsonField=expanded_url
    public var expandedUrl: String!
    
    // sourcery: jsonField=indices
    public var indices: [Int32]!
    
    required public init() {
        
    }
}
