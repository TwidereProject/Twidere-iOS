// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class TwitterURLEntityJsonMapper: JsonMapper<TwitterURLEntity> {

    internal static let singleton = TwitterURLEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterURLEntity! {
        let instance = TwitterURLEntity()
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

    override func parseField(_ instance: TwitterURLEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            TwitterBaseEntityJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
