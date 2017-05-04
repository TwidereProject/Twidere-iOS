// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

internal class MastodonAccountsServicesRestImpl: MastodonAccountsServices, RestProtocolService {

    let client: RestClient

    required init(client: RestClient) {
        self.client = client
    }

    func getAccount(id: String) -> Promise<MastodonAccount> {
        let call = RestCall<MastodonAccount>()
        call.method = .get
        call.path = "/v1/accounts/\(id)"
        call.serializer = MastodonAccountJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
