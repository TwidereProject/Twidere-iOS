// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class MediaEntityJsonMapper: JsonMapper<MediaEntity> {

    internal static let singleton = MediaEntityJsonMapper()

    override internal func parse(_ parser: JsonParser) -> MediaEntity! {
        let instance = MediaEntity()
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

    override internal func parseField(_ instance: MediaEntity, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        default:
            UrlEntityJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
