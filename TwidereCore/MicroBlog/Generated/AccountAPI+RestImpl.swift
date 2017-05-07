// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

internal class AccountAPIRestImpl: AccountAPI, RestAPIProtocol {

    let client: RestClient

    required internal init(client: RestClient) {
        self.client = client
    }

    internal func verifyCredentials() -> Promise<User> {
        let call = RestCall<User>()
        call.method = .get
        call.path = "/account/verify_credentials.json"
        call.serializer = UserJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
