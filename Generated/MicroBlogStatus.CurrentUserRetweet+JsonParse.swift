// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal extension MicroBlogStatus.CurrentUserRetweet {

    internal static func parse(_ instance: MicroBlogStatus.CurrentUserRetweet = MicroBlogStatus.CurrentUserRetweet(), parser: PMJacksonParser) -> MicroBlogStatus.CurrentUserRetweet! {
        if (parser.currentEvent == nil) {
            parser.nextEvent()
        }

        if (parser.currentEvent != .objectStart) {
            parser.skipChildren()
            return nil
        }

        while (parser.nextEvent() != .objectEnd) {
            let fieldName = parser.currentName!
            parser.nextEvent()
            parseField(instance, fieldName, parser)
            parser.skipChildren()
        }
        return instance
    }

    internal static func parseField(_ instance: MicroBlogStatus.CurrentUserRetweet, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        default:
            break
        }
    }
}
