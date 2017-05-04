// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension UserEntities: JsonMappable {

}

internal class UserEntitiesJsonMapper: JsonMapper<UserEntities> {

    internal static let singleton = UserEntitiesJsonMapper()

    override func parse(_ parser: JsonParser) -> UserEntities! {
        let instance = UserEntities()
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

    override func parseField(_ instance: UserEntities, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "url":
            instance.url = EntitiesJsonMapper.singleton.parse(parser)
        case "description":
            instance.description = EntitiesJsonMapper.singleton.parse(parser)
        default:
            break
        }
    }
}
