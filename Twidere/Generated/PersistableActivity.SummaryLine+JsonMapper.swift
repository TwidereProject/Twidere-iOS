// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableActivity.SummaryLine: JsonMappable {

}

internal class PersistableActivitySummaryLineJsonMapper: JsonMapper<PersistableActivity.SummaryLine> {

    internal static let singleton = PersistableActivitySummaryLineJsonMapper()

    override func parse(_ parser: JsonParser) -> PersistableActivity.SummaryLine! {
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

    override func parseField(_ instance: PersistableActivity.SummaryLine, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
