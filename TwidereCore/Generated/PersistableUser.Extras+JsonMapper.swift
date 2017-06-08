// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

extension PersistableUser.Extras: JsonMappable {

}

public class PersistableUserExtrasJsonMapper: JsonMapper<PersistableUser.Extras> {

    public static let singleton = PersistableUserExtrasJsonMapper()

    override public func parse(_ parser: JsonParser) -> PersistableUser.Extras! {
        let instance = PersistableUser.Extras()
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

    override public func parseField(_ instance: PersistableUser.Extras, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "statusnet_profile_url":
            instance.statusnet_profile_url = parser.getValueAsString()
        case "ostatus_uri":
            instance.ostatus_uri = parser.getValueAsString()
        case "profile_image_url_original":
            instance.profile_image_url_original = parser.getValueAsString()
        case "profile_image_url_fallback":
            instance.profile_image_url_fallback = parser.getValueAsString()
        case "groups_count":
            instance.groups_count = parser.getValueAsInt64()
        case "unique_id":
            instance.unique_id = parser.getValueAsString()
        case "blocking":
            instance.blocking = parser.getValueAsBool()
        case "blocked_by":
            instance.blocked_by = parser.getValueAsBool()
        case "followed_by":
            instance.followed_by = parser.getValueAsBool()
        case "muting":
            instance.muting = parser.getValueAsBool()
        case "notifications_enabled":
            instance.notifications_enabled = parser.getValueAsBool()
        case "pinned_status_ids":
            if (parser.currentEvent == .arrayStart) {
                var array: [String] = []
                while (parser.nextEvent() != .arrayEnd) {
                    array.append(parser.getValueAsString())
                }
                instance.pinned_status_ids = array
            } else {
                instance.pinned_status_ids = nil
            }
        default:
            break
        }
    }
}
