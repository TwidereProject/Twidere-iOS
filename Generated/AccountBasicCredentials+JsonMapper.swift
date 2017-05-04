// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class AccountBasicCredentialsJsonMapper: JsonMapper<AccountBasicCredentials> {

    internal static let singleton = AccountBasicCredentialsJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> AccountBasicCredentials! {
        let instance = AccountBasicCredentials()
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

    override func parseField(_ instance: AccountBasicCredentials, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        case "username":
            instance.username = parser.getValueAsString()
        case "password":
            instance.password = parser.getValueAsString()
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
