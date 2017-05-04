// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

internal class MicroBlogAccountServiceRestImpl: MicroBlogAccountService, RestProtocolService {

    let client: RestClient

    required init(client: RestClient) {
        self.client = client
    }

    func verifyCredentials() -> Promise<MicroBlogUser> {
        let call = RestCall<MicroBlogUser>()
        call.method = .get
        call.path = "/account/verify_credentials.json"
        call.serializer = MicroBlogUserJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
