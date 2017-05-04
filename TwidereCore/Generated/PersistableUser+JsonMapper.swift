// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableUser: JsonMappable {

}

internal class PersistableUserJsonMapper: JsonMapper<PersistableUser> {

    internal static let singleton = PersistableUserJsonMapper()

    override internal func parse(_ parser: JsonParser) -> PersistableUser! {
        let instance = PersistableUser()
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

    override internal func parseField(_ instance: PersistableUser, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
