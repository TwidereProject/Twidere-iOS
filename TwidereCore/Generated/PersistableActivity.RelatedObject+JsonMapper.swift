// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableActivity.RelatedObject: JsonMappable {

}

public class PersistableActivityRelatedObjectJsonMapper: JsonMapper<PersistableActivity.RelatedObject> {

    public static let singleton = PersistableActivityRelatedObjectJsonMapper()

    override public func parse(_ parser: JsonParser) -> PersistableActivity.RelatedObject! {
        let instance = PersistableActivity.RelatedObject()
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

    override public func parseField(_ instance: PersistableActivity.RelatedObject, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            break
        }
    }
}
