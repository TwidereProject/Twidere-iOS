// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MastodonAccount: JsonMappable {

}

internal class MastodonAccountJsonMapper: JsonMapper<MastodonAccount> {

    internal static let singleton = MastodonAccountJsonMapper()

    override func parse(_ instance: MastodonAccount = MastodonAccount(), parser: PMJacksonParser) -> MastodonAccount! {
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

    override func parseField(_ instance: MastodonAccount, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
