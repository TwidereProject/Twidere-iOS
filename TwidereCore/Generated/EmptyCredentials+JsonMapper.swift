// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

public class EmptyCredentialsJsonMapper: JsonMapper<EmptyCredentials> {

    public static let singleton = EmptyCredentialsJsonMapper()

    override public func parse(_ parser: JsonParser) -> EmptyCredentials! {
        let instance = EmptyCredentials()
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

    override public func parseField(_ instance: EmptyCredentials, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
