// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

internal class PersistableActivityJsonMapper: JsonMapper<PersistableActivity> {

    internal static let singleton = PersistableActivityJsonMapper()

    override func parse(_ parser: JsonParser) -> PersistableActivity! {
        let instance = PersistableActivity()
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

    override func parseField(_ instance: PersistableActivity, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "action":
            instance.action = parser.getValueAsString()
        case "max_position":
            instance.max_sort_position = parser.getValueAsInt64()
        case "min_position":
            instance.min_sort_position = parser.getValueAsInt64()
        case "max_request_position":
            instance.max_position = parser.getValueAsString()
        case "min_request_position":
            instance.min_position = parser.getValueAsString()
        case "source_keys":
            if (parser.currentEvent == .arrayStart) {
                var array: [UserKey] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(UserKeyFieldConverter.parse(parser))
                }
                instance.source_keys = array
            } else {
                instance.source_keys = nil
            }
        case "sources":
            if (parser.currentEvent == .arrayStart) {
                var array: [PersistableUser] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(PersistableUserJsonMapper.singleton.parse(parser))
                }
                instance.sources = array
            } else {
                instance.sources = nil
            }
        case "targets":
            instance.targets = PersistableActivityRelatedObjectJsonMapper.singleton.parse(parser)
        case "target_objects":
            instance.target_objects = PersistableActivityRelatedObjectJsonMapper.singleton.parse(parser)
        case "sources_lite":
            if (parser.currentEvent == .arrayStart) {
                var array: [PersistableLiteUser] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(PersistableLiteUserJsonMapper.singleton.parse(parser))
                }
                instance.sources_lite = array
            } else {
                instance.sources_lite = nil
            }
        case "summary_line":
            if (parser.currentEvent == .arrayStart) {
                var array: [PersistableActivity.SummaryLine] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(PersistableActivitySummaryLineJsonMapper.singleton.parse(parser))
                }
                instance.summary_line = array
            } else {
                instance.summary_line = nil
            }
        case "has_following_source":
            instance.has_following_source = parser.getValueAsBool()
        default:
            PersistableStatusJsonMapper.singleton.parseField(instance, fieldName, parser)
        }
    }
}
