// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension CardEntity: JsonMappable {

}

internal class CardEntityJsonMapper: JsonMapper<CardEntity> {

    internal static let singleton = CardEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> CardEntity! {
        let instance = CardEntity()
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

    override func parseField(_ instance: CardEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
