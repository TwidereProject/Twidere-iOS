// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension MentionItem: JsonMappable {

}

internal class MentionItemJsonMapper: JsonMapper<MentionItem> {

    internal static let singleton = MentionItemJsonMapper()

    override func parse(_ parser: JsonParser) -> MentionItem! {
        let instance = MentionItem()
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

    override func parseField(_ instance: MentionItem, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
