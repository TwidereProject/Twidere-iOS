// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension LinkSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> LinkSpanItem {
        let start: Int = try value.decode(at: "start", or: -1)
        let end: Int = try value.decode(at: "end", or: -1)
        let link: String = try value.decode(at: "link")
        let display: String? = try? value.decode(at: "display")
        return LinkSpanItem(start: start, end: end, link: link, display: display)
    }

}

extension LinkSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["link"] = self.link.toJSON()
        if (display != nil) {
            dict["display"] = self.display!.toJSON()
        }
        return .dictionary(dict)
    }
}

extension MentionSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> MentionSpanItem {
        let start: Int = try value.decode(at: "start", or: -1)
        let end: Int = try value.decode(at: "end", or: -1)
        let key: UserKey = try value.decode(at: "key")
        let name: String? = try? value.decode(at: "name")
        let screenName: String = try value.decode(at: "screen_name")
        return MentionSpanItem(start: start, end: end, key: key, name: name, screenName: screenName)
    }

}

extension MentionSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["key"] = self.key.toJSON()
        if (name != nil) {
            dict["name"] = self.name!.toJSON()
        }
        dict["screen_name"] = self.screenName.toJSON()
        return .dictionary(dict)
    }
}

extension HashtagSpanItem: JSONStaticDecodable {

    static func fromJSON(json value: Freddy.JSON) throws -> HashtagSpanItem {
        let start: Int = try value.decode(at: "start", or: -1)
        let end: Int = try value.decode(at: "end", or: -1)
        let hashtag: String = try value.decode(at: "hashtag")
        return HashtagSpanItem(start: start, end: end, hashtag: hashtag)
    }

}

extension HashtagSpanItem: JSONEncodable {
    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["hashtag"] = self.hashtag.toJSON()
        return .dictionary(dict)
    }
}

