// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension LinkSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> LinkSpanItem {
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let origStart: Int = try value.decode(at: "start")
        let origEnd: Int = try value.decode(at: "end")
        let link: String = try value.decode(at: "link")
        let display: String = try value.decode(at: "display")
        return LinkSpanItem(start: start, end: end, origStart: origStart, origEnd: origEnd, link: link, display: display)
    }

}

extension LinkSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension MentionSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> MentionSpanItem {
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let origStart: Int = try value.decode(at: "start")
        let origEnd: Int = try value.decode(at: "end")
        let key: UserKey = try value.decode(at: "key")
        let name: String = try value.decode(at: "name")
        let screenName: String = try value.decode(at: "screen_name")
        return MentionSpanItem(start: start, end: end, origStart: origStart, origEnd: origEnd, key: key, name: name, screenName: screenName)
    }

}

extension MentionSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

extension HashtagSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> HashtagSpanItem {
        let start: Int = try value.decode(at: "start")
        let end: Int = try value.decode(at: "end")
        let origStart: Int = try value.decode(at: "start")
        let origEnd: Int = try value.decode(at: "end")
        let hashtag: String = try value.decode(at: "hashtag")
        return HashtagSpanItem(start: start, end: end, origStart: origStart, origEnd: origEnd, hashtag: hashtag)
    }

}

extension HashtagSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        let dict: [String: JSON] = [:]
//{toJsonContent}
        return .dictionary(dict)
    }
}

