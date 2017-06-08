// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableActivity.SummaryLine: JsonMappable {

}

public class PersistableActivitySummaryLineJsonMapper: JsonMapper<PersistableActivity.SummaryLine> {

    public static let singleton = PersistableActivitySummaryLineJsonMapper()

    override public func parse(_ parser: JsonParser) -> PersistableActivity.SummaryLine! {
        let instance = PersistableActivity.SummaryLine()
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

    override public func parseField(_ instance: PersistableActivity.SummaryLine, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "key":
            instance.key = UserKeyFieldConverter.parse(parser)
        case "name":
            instance.name = parser.getValueAsString()
        case "screen_name":
            instance.screen_name = parser.getValueAsString()
        case "content":
            instance.content = parser.getValueAsString()
        default:
            break
        }
    }
}
