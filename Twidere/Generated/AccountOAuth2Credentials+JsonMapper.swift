// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class AccountOAuth2CredentialsJsonMapper: JsonMapper<AccountOAuth2Credentials> {

    internal static let singleton = AccountOAuth2CredentialsJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> AccountOAuth2Credentials! {
        let instance = AccountOAuth2Credentials()
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

    override func parseField(_ instance: AccountOAuth2Credentials, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "access_token":
            instance.access_token = parser.getValueAsString()
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
