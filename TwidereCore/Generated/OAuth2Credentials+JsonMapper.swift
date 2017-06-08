// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

public class OAuth2CredentialsJsonMapper: JsonMapper<OAuth2Credentials> {

    public static let singleton = OAuth2CredentialsJsonMapper()

    override public func parse(_ parser: JsonParser) -> OAuth2Credentials! {
        let instance = OAuth2Credentials()
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

    override public func parseField(_ instance: OAuth2Credentials, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "access_token":
            instance.access_token = parser.getValueAsString()
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
