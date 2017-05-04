// sourcery: jsonParse
class SpanItem {

    var start: Int = 0
    var end: Int = 0
    var origStart: Int = -1
    var origEnd: Int = -1
    
    var link: String!
    var type: SpanType = .link
    
    required init() {
        
    }
    
    enum SpanType: Int {
        case hide = -1, link = 0, mention = 1
    }

}
