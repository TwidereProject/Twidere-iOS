// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension Status.CurrentUserRetweet: JsonMappable {

}

internal class StatusCurrentUserRetweetJsonMapper: JsonMapper<Status.CurrentUserRetweet> {

    internal static let singleton = StatusCurrentUserRetweetJsonMapper()

    override func parse(_ parser: JsonParser) -> Status.CurrentUserRetweet! {
        let instance = Status.CurrentUserRetweet()
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

    override func parseField(_ instance: Status.CurrentUserRetweet, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        default:
            break
        }
    }
}
