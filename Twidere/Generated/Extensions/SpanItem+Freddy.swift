// Automatically generated, DO NOT MODIFY
import Freddy
import Foundation

extension LinkSpanItem: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.start = try value.decode(at: "start")
        self.end = try value.decode(at: "end")
        self.origStart = try value.decode(at: "start")
        self.origEnd = try value.decode(at: "end")
        self.link = try value.decode(at: "link")
        self.display = try value.decode(at: "display")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["start"] = self.origStart.toJSON()
        dict["end"] = self.origEnd.toJSON()
        dict["link"] = self.link.toJSON()
        dict["display"] = self.display.toJSON()
        return .dictionary(dict)
    }
}


extension MentionSpanItem: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.start = try value.decode(at: "start")
        self.end = try value.decode(at: "end")
        self.origStart = try value.decode(at: "start")
        self.origEnd = try value.decode(at: "end")
        self.key = try value.decode(at: "key")
        self.name = try value.decode(at: "name")
        self.screenName = try value.decode(at: "screen_name")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["start"] = self.origStart.toJSON()
        dict["end"] = self.origEnd.toJSON()
        dict["key"] = self.key.toJSON()
        dict["name"] = self.name.toJSON()
        dict["screen_name"] = self.screenName.toJSON()
        return .dictionary(dict)
    }
}


extension HashtagSpanItem: JSONEncodable, JSONDecodable {

    init(json value: JSON) throws {
        self.start = try value.decode(at: "start")
        self.end = try value.decode(at: "end")
        self.origStart = try value.decode(at: "start")
        self.origEnd = try value.decode(at: "end")
        self.hashtag = try value.decode(at: "hashtag")
    }

    public func toJSON() -> JSON {
        var dict: [String: JSON] = [:]
        dict["start"] = self.start.toJSON()
        dict["end"] = self.end.toJSON()
        dict["start"] = self.origStart.toJSON()
        dict["end"] = self.origEnd.toJSON()
        dict["hashtag"] = self.hashtag.toJSON()
        return .dictionary(dict)
    }
}


