// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension LinkSpanItem: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> LinkSpanItem {
        var obj = LinkSpanItem()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


extension MentionSpanItem: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MentionSpanItem {
        var obj = MentionSpanItem()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


extension HashtagSpanItem: JSONEncodable, JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> HashtagSpanItem {
        var obj = HashtagSpanItem()
//{initContent}
        return obj
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}


