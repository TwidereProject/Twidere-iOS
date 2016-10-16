// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension LinkSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> LinkSpanItem {
        var obj = LinkSpanItem()
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let link: String = try value.decode(at: "link")
        let display: String = try value.decode(at: "display")
        return obj
    }

}

extension LinkSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MentionSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> MentionSpanItem {
        var obj = MentionSpanItem()
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let key: UserKey = try value.decode(at: "key")
        let name: String = try value.decode(at: "name")
        let screenName: String = try value.decode(at: "screen_name")
        return obj
    }

}

extension MentionSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension HashtagSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: JSON) throws -> HashtagSpanItem {
        var obj = HashtagSpanItem()
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let hashtag: String = try value.decode(at: "hashtag")
        return obj
    }

}

extension HashtagSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

