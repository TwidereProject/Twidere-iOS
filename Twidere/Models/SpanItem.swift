// Automatically generated, DO NOT MODIFY
import Foundation

protocol SpanItem {

    // Fields
    var start: Int { get set }
    var end: Int { get set }
    var origStart: Int { get set }
    var origEnd: Int { get set }
    // Initializers

    // Append body content

    // Sub models

}

class LinkSpanItem : SpanItem {

    // Fields
    var start: Int = -1
    var end: Int = -1
    var origStart: Int = -1
    var origEnd: Int = -1
    var link: String
    var display: String!
    // Initializers
    init(start: Int = -1, end: Int = -1, origStart: Int = -1, origEnd: Int = -1, link: String, display: String! = nil) {
        self.start = start
        self.end = end
        self.origStart = origStart
        self.origEnd = origEnd
        self.link = link
        self.display = display
    }
    // Append body content

    // Sub models

}

class MentionSpanItem : SpanItem {

    // Fields
    var start: Int = -1
    var end: Int = -1
    var origStart: Int = -1
    var origEnd: Int = -1
    var key: UserKey
    var name: String!
    var screenName: String
    // Initializers
    init(start: Int = -1, end: Int = -1, origStart: Int = -1, origEnd: Int = -1, key: UserKey, name: String! = nil, screenName: String) {
        self.start = start
        self.end = end
        self.origStart = origStart
        self.origEnd = origEnd
        self.key = key
        self.name = name
        self.screenName = screenName
    }
    // Append body content

    // Sub models

}

class HashtagSpanItem : SpanItem {

    // Fields
    var start: Int = -1
    var end: Int = -1
    var origStart: Int = -1
    var origEnd: Int = -1
    var hashtag: String
    // Initializers
    init(start: Int = -1, end: Int = -1, origStart: Int = -1, origEnd: Int = -1, hashtag: String) {
        self.start = start
        self.end = end
        self.origStart = origStart
        self.origEnd = origEnd
        self.hashtag = hashtag
    }
    // Append body content

    // Sub models

}
