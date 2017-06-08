// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

public class AccountsAPIRestImpl: AccountsAPI, RestAPIProtocol {

    let client: RestClient

    required public init(client: RestClient) {
        self.client = client
    }

    public func getAccount(id: String) -> Promise<Account> {
        let call = RestCall<Account>()
        call.method = .get
        call.path = "/v1/accounts/\(id)"
        call.serializer = AccountJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
