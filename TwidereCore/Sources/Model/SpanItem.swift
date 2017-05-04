// sourcery: jsonParse
public class SpanItem {

    public var start: Int = 0
    public var end: Int = 0
    public var origStart: Int = -1
    public var origEnd: Int = -1
    
    public var link: String!
    public var type: SpanType = .link
    
    required public init() {
        
    }
    
    public enum SpanType: Int {
        case hide = -1, link = 0, mention = 1
    }

}
