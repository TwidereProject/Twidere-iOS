// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class TwitterHashtagEntityJsonMapper: JsonMapper<TwitterHashtagEntity> {

    internal static let singleton = TwitterHashtagEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterHashtagEntity! {
        let instance = TwitterHashtagEntity()
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

    override func parseField(_ instance: TwitterHashtagEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            TwitterBaseEntityJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
