// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson
import RestCommons

extension Account: JsonMappable {

}

public class AccountJsonMapper: JsonMapper<Account> {

    public static let singleton = AccountJsonMapper()

    override public func parse(_ parser: JsonParser) -> Account! {
        let instance = Account()
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

    override public func parseField(_ instance: Account, _ fieldName: String, _ parser: JsonParser) {
        switch fieldName {
        case "id":
            instance.id = parser.getValueAsString()
        case "username":
            instance.username = parser.getValueAsString()
        case "acct":
            instance.acct = parser.getValueAsString()
        case "display_name":
            instance.displayName = parser.getValueAsString()
        case "locked":
            instance.locked = parser.getValueAsBool()
        case "created_at":
            instance.createdAt = ISO8601DateFieldConverter.parse(parser)
        case "followers_count":
            instance.followersCount = parser.getValueAsInt64()
        case "following_count":
            instance.followingCount = parser.getValueAsInt64()
        case "statuses_count":
            instance.statusesCount = parser.getValueAsInt64()
        case "note":
            instance.note = parser.getValueAsString()
        case "url":
            instance.url = parser.getValueAsString()
        case "avatar":
            instance.avatar = parser.getValueAsString()
        case "avatar_static":
            instance.avatarStatic = parser.getValueAsString()
        case "header":
            instance.header = parser.getValueAsString()
        case "header_static":
            instance.headerStatic = parser.getValueAsString()
        default:
            break
        }
    }
}
