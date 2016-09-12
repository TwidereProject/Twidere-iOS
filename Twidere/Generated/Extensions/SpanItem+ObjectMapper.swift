// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension LinkSpanItem: StaticMappable {

    func mapping(map: Map) {
        link <- map["link"]
        display <- map["display"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return LinkSpanItem()
    }
}


extension MentionSpanItem: StaticMappable {

    func mapping(map: Map) {
        key <- map["key"]
        name <- map["name"]
        screenName <- map["screenName"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MentionSpanItem()
    }
}


extension HashtagSpanItem: StaticMappable {

    func mapping(map: Map) {
        hashtag <- map["hashtag"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return HashtagSpanItem()
    }
}


