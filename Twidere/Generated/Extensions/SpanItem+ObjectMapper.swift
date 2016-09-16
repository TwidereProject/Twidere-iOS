// Automatically generated, DO NOT MODIFY
import ObjectMapper
import Foundation

extension LinkSpanItem: StaticMappable {

    func mapping(map: Map) {
        start <- map["start"]
        end <- map["end"]
        link <- map["link"]
        display <- map["display"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return LinkSpanItem()
    }
}


extension MentionSpanItem: StaticMappable {

    func mapping(map: Map) {
        start <- map["start"]
        end <- map["end"]
        key <- (map["key"], UserKeyTransform())
        name <- map["name"]
        screenName <- map["screen_name"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return MentionSpanItem()
    }
}


extension HashtagSpanItem: StaticMappable {

    func mapping(map: Map) {
        start <- map["start"]
        end <- map["end"]
        hashtag <- map["hashtag"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return HashtagSpanItem()
    }
}


