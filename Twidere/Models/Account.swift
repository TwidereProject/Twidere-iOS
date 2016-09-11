import SQLite

class Account {

    var _id: Int64!
    var key: UserKey!
    var type: String!
    var apiUrlFormat: String!
    var authType: String!
    var basicPassword: String?
    var basicUsername: String?
    var consumerKey: String?
    var consumerSecret: String?
    var noVersionSuffix: Bool!
    var oauthToken: String?
    var oauthTokenSecret: String?
    var sameOAuthSigningUrl: Bool!
    var config: AccountConfig!
    var user: User!

    init() {

    }

}