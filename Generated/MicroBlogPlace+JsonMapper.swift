// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class MicroBlogPlaceJsonMapper: JsonMapper<MicroBlogPlace> {

    internal static let singleton = MicroBlogPlaceJsonMapper()

    override func parse(_ instance: MicroBlogPlace = MicroBlogPlace(), parser: PMJacksonParser) -> MicroBlogPlace! {
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

    override func parseField(_ instance: MicroBlogPlace, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "full_name":
            instance.fullName = parser.getValueAsString()
        default:
            break
        }
    }
}
