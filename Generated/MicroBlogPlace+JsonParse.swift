// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MicroBlogPlace {

    static func parse(parser: PMJacksonParser) -> MicroBlogPlace! {
        let instance = MicroBlogPlace()
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

    private static func parseField(_ instance: MicroBlogPlace, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
                    case "full_name": instance.fullName = parser.getValueAsString()
        default: break
        }
    }
}
