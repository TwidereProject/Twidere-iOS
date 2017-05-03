// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit

internal class MicroBlogAccountServiceRestImpl: MicroBlogAccountService {

    let client: RestClient

    init(client: RestClient) {
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
