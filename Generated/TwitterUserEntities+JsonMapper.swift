// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension TwitterUserEntities: JsonMappable {

}

internal class TwitterUserEntitiesJsonMapper: JsonMapper<TwitterUserEntities> {

    internal static let singleton = TwitterUserEntitiesJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> TwitterUserEntities! {
        let instance = TwitterUserEntities()
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

    override func parseField(_ instance: TwitterUserEntities, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "url":
            instance.url = TwitterEntitiesJsonMapper.singleton.parse(parser)
        case "description":
            instance.description = TwitterEntitiesJsonMapper.singleton.parse(parser)
        default:
            break
        }
    }
}
