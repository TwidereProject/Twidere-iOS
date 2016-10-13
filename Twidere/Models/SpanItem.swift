// Automatically generated, DO NOT MODIFY
import Foundation

protocol SpanItem {

    // Fields
    var start: Int { get set }
    var end: Int { get set }
    var origStart: Int { get set }
    var origEnd: Int { get set }
    // Append body content

    // Sub models


}
struct LinkSpanItem : SpanItem {

    // Fields
    var start: Int 
    var end: Int 
    var origStart: Int 
    var origEnd: Int 
    var link: String 
    var display: String! 
    // Append body content

    // Sub models


}
struct MentionSpanItem : SpanItem {

    // Fields
    var start: Int 
    var end: Int 
    var origStart: Int 
    var origEnd: Int 
    var key: UserKey? 
    var name: String? 
    var screenName: String 
    // Append body content

    // Sub models


}
struct HashtagSpanItem : SpanItem {

    // Fields
    var start: Int 
    var end: Int 
    var origStart: Int 
    var origEnd: Int 
    var hashtag: String 
    // Append body content

    // Sub models


}
