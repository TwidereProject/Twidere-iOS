// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

internal class AccountsAPIRestImpl: AccountsAPI, RestAPIProtocol {

    let client: RestClient

    required internal init(client: RestClient) {
        self.client = client
    }

    internal func getAccount(id: String) -> Promise<Account> {
        let call = RestCall<Account>()
        call.method = .get
        call.path = "/v1/accounts/\(id)"
        call.serializer = MastodonAccountJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
