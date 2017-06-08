// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

public class OAuthAPIRestImpl: OAuthAPI, RestAPIProtocol {

    let client: RestClient

    required public init(client: RestClient) {
        self.client = client
    }

    public func getRequestToken(_ oauthCallback: String) -> Promise<OAuthToken> {
        let call = RestCall<OAuthToken>()
        call.method = .post
        call.path = "/oauth/request_token"
        call.params = [
            "oauth_callback": oauthCallback,
        ]
        call.serializer = OAuthTokenResponseSerializer
        return client.toPromise(call)
    }

    public func getAccessToken(username: String, password: String) -> Promise<OAuthToken> {
        let call = RestCall<OAuthToken>()
        call.method = .post
        call.path = "/oauth/access_token"
        call.params = [
            "x_auth_password": password,
            "x_auth_username": username,
            "x_auth_mode": "client_auth",
        ]
        call.serializer = OAuthTokenResponseSerializer
        return client.toPromise(call)
    }

    public func getAccessToken(_ verifier: String?) -> Promise<OAuthToken> {
        let call = RestCall<OAuthToken>()
        call.method = .post
        call.path = "/oauth/access_token"
        call.params = [
            "oauth_verifier": verifier,
        ]
        call.serializer = OAuthTokenResponseSerializer
        return client.toPromise(call)
    }

}
