// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class TwitterMentionEntityJsonMapper: JsonMapper<TwitterMentionEntity> {

    internal static let singleton = TwitterMentionEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterMentionEntity! {
        let instance = TwitterMentionEntity()
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

    override func parseField(_ instance: TwitterMentionEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            TwitterBaseEntityJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
