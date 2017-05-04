// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

public class OAuthCredentialsJsonMapper: JsonMapper<OAuthCredentials> {

    public static let singleton = OAuthCredentialsJsonMapper()

    override public func parse(_ parser: JsonParser) -> OAuthCredentials! {
        let instance = OAuthCredentials()
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

    override public func parseField(_ instance: OAuthCredentials, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "consumer_key":
            instance.consumer_key = parser.getValueAsString()
        case "consumer_secret":
            instance.consumer_secret = parser.getValueAsString()
        case "access_token":
            instance.access_token = parser.getValueAsString()
        case "access_token_secret":
            instance.access_token_secret = parser.getValueAsString()
        case "same_oauth_signing_url":
            instance.same_oauth_signing_url = parser.getValueAsBool()
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
