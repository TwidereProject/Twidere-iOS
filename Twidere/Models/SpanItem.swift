// Automatically generated, DO NOT MODIFY
import Foundation

class SpanItem {

    // Fields
    var start: Int = -1
    var end: Int = -1
    var origStart: Int = -1
    var origEnd: Int = -1
    // Initializers
    init(start: Int = -1, end: Int = -1, origStart: Int = -1, origEnd: Int = -1) {
        self.start = start
        self.end = end
        self.origStart = origStart
        self.origEnd = origEnd
    }
    // Append body content

    // Sub models


}
class LinkSpanItem : SpanItem {

    // Fields
    var link: String
    var display: String!
    // Initializers
    init(link: String, display: String!) {
        self.link = link
        self.display = display
    }
    // Append body content

    // Sub models


}
class MentionSpanItem : SpanItem {

    // Fields
    var key: UserKey
    var name: String?
    var screenName: String
    // Initializers
    init(key: UserKey, name: String?, screenName: String) {
        self.key = key
        self.name = name
        self.screenName = screenName
    }
    // Append body content

    // Sub models


}
class HashtagSpanItem : SpanItem {

    // Fields
    var hashtag: String
    // Initializers
    init(hashtag: String) {
        self.hashtag = hashtag
    }
    // Append body content

    // Sub models


}
