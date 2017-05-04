// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableCardEntity: JsonMappable {

}

internal class PersistableCardEntityJsonMapper: JsonMapper<PersistableCardEntity> {

    internal static let singleton = PersistableCardEntityJsonMapper()

    override func parse(_ parser: PMJacksonParser) -> PersistableCardEntity! {
        let instance = PersistableCardEntity()
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

    override func parseField(_ instance: PersistableCardEntity, _ fieldName: String, _ parser: PMJacksonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
