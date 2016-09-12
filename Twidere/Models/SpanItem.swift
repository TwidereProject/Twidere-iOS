// Automatically generated, DO NOT MODIFY
import Foundation

class SpanItem {

    // Fields
    var start: Int = -1
    var end: Int = -1
    var origStart: Int = -1
    var origEnd: Int = -1
    // Append body content

    // Sub models


}
class LinkSpanItem : SpanItem {

    // Fields
    var link: String!
    var display: String!
    // Append body content

    // Sub models


}
class MentionSpanItem : SpanItem {

    // Fields
    var key: UserKey!
    var name: String!
    var screenName: String!
    // Append body content

    // Sub models


}
class HashtagSpanItem : SpanItem {

    // Fields
    var hashtag: String!
    // Append body content

    // Sub models


}
