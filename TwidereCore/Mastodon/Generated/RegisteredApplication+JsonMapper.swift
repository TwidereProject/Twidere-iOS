// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension RegisteredApplication: JsonMappable {

}

public class RegisteredApplicationJsonMapper: JsonMapper<RegisteredApplication> {

    public static let singleton = RegisteredApplicationJsonMapper()

    override public func parse(_ parser: JsonParser) -> RegisteredApplication! {
        let instance = RegisteredApplication()
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

    override public func parseField(_ instance: RegisteredApplication, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
