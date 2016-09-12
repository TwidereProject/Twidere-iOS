import MessagePack_swift


extension Account {

    convenience init(_ value: MessagePackValue) {
        value.dictionaryValue?.forEach { k, v in
            guard let ks = k.stringValue else {
                return
            }
            switch ks {
            case "_id":
                self._id = v.int64Value
            case "key":
                self.key = v.userKeyValue
            case "type":
                self.type = v.stringValue
            case "apiUrlFormat":
                self.apiUrlFormat = v.stringValue
            case "authType":
                self.authType = v.stringValue
            case "basicPassword":
                self.basicPassword = v.stringValue
            case "basicUsername":
                self.basicUsername = v.stringValue
            case "consumerKey":
                self.consumerKey = v.stringValue
            case "consumerSecret":
                self.consumerSecret = v.stringValue
            case "noVersionSuffix":
                self.noVersionSuffix = v.boolValue
            case "oauthToken":
                self.oauthToken = v.stringValue
            case "oauthTokenSecret":
                self.oauthTokenSecret = v.stringValue
            case "sameOAuthSigningUrl":
                self.sameOAuthSigningUrl = v.boolValue
            case "config":
                self.config = v.configValue
            case "user":
                self.user = v.userValue
            default: break
            }
        }
    }

    func messagePackValue() -> MessagePackValue {
        var map: [MessagePackValue: MessagePackValue] = [:]
        if (self._id != nil) {
            map[.String("_id")] = MessagePackValue(self._id!)
        }
        if (self.key != nil) {
            map[.String("key")] = MessagePackValue(self.key!)
        }
        if (self.type != nil) {
            map[.String("type")] = MessagePackValue(self.type!)
        }
        if (self.apiUrlFormat != nil) {
            map[.String("apiUrlFormat")] = MessagePackValue(self.apiUrlFormat!)
        }
        if (self.authType != nil) {
            map[.String("authType")] = MessagePackValue(self.authType!)
        }
        if (self.basicPassword != nil) {
            map[.String("basicPassword")] = MessagePackValue(self.basicPassword!)
        }
        if (self.basicUsername != nil) {
            map[.String("basicUsername")] = MessagePackValue(self.basicUsername!)
        }
        if (self.consumerKey != nil) {
            map[.String("consumerKey")] = MessagePackValue(self.consumerKey!)
        }
        if (self.consumerSecret != nil) {
            map[.String("consumerSecret")] = MessagePackValue(self.consumerSecret!)
        }
        if (self.noVersionSuffix != nil) {
            map[.String("noVersionSuffix")] = MessagePackValue(self.noVersionSuffix!)
        }
        if (self.oauthToken != nil) {
            map[.String("oauthToken")] = MessagePackValue(self.oauthToken!)
        }
        if (self.oauthTokenSecret != nil) {
            map[.String("oauthTokenSecret")] = MessagePackValue(self.oauthTokenSecret!)
        }
        if (self.sameOAuthSigningUrl != nil) {
            map[.String("sameOAuthSigningUrl")] = MessagePackValue(self.sameOAuthSigningUrl!)
        }
        if (self.config != nil) {
            map[.String("config")] = MessagePackValue(self.config!)
        }
        if (self.user != nil) {
            map[.String("user")] = MessagePackValue(self.user!)
        }
        return map
    }

}

extension MessagePackValue {
    init(_ value: Account) {
        self = value.messagePackValue()
    }

    var accountValue: Account? {
        switch self {
        case let .Map(map):
            return Account(map)
        default:
            return nil
        }
    }
}


extension Account.Config {

    convenience init(_ value: MessagePackValue) {
        value.dictionaryValue?.forEach { k, v in
            guard let ks = k.stringValue else {
                return
            }
            switch ks {
            case "characterLimit":
                self.characterLimit = v.intValue
            default: break
            }
        }
    }

    func messagePackValue() -> MessagePackValue {
        var map: [MessagePackValue: MessagePackValue] = [:]
        if (self.characterLimit != nil) {
            map[.String("characterLimit")] = MessagePackValue(self.characterLimit!)
        }
        return map
    }
}

extension MessagePackValue {
    init(_ value: Account.Config) {
        self = value.messagePackValue()
    }

    var accountConfigValue: Account.Config? {
        switch self {
        case let .Map(map):
            return Account.Config(map)
        default:
            return nil
        }
    }
}
