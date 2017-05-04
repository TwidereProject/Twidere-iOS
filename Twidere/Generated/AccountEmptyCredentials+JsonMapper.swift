// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class AccountEmptyCredentialsJsonMapper: JsonMapper<AccountEmptyCredentials> {

    internal static let singleton = AccountEmptyCredentialsJsonMapper()

    override func parse(_ parser: JsonParser) -> AccountEmptyCredentials! {
        let instance = AccountEmptyCredentials()
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

    override func parseField(_ instance: AccountEmptyCredentials, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            AccountDetailsCredentialsJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
