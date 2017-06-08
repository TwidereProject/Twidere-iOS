// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

public class FavoritesAPIRestImpl: FavoritesAPI, RestAPIProtocol {

    let client: RestClient

    required public init(client: RestClient) {
        self.client = client
    }

    public func createFavorite(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/favorites/create.json"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func destroyFavorite(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/favorites/destroy.json"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
