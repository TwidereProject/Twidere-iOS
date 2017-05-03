// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension TwitterCardEntity: JsonMappable {

}

internal class TwitterCardEntityJsonMapper: JsonMapper<TwitterCardEntity> {

    internal static let singleton = TwitterCardEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterCardEntity! {
        let instance = TwitterCardEntity()
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

    override func parseField(_ instance: TwitterCardEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
