// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension AccountDetails.Credentials: JsonMappable {

}

public class AccountDetailsCredentialsJsonMapper: JsonMapper<AccountDetails.Credentials> {

    public static let singleton = AccountDetailsCredentialsJsonMapper()

    override public func parse(_ parser: JsonParser) -> AccountDetails.Credentials! {
        let instance = AccountDetails.Credentials()
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

    override public func parseField(_ instance: AccountDetails.Credentials, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "api_url_format":
            instance.api_url_format = parser.getValueAsString()
        case "no_version_suffix":
            instance.no_version_suffix = parser.getValueAsBool()
        default:
            break
        }
    }
}
