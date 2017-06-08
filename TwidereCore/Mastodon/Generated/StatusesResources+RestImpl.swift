// Generated using Sourcery 0.6.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

public class StatusesResourcesRestImpl: StatusesResources, RestAPIProtocol {

    let client: RestClient

    required public init(client: RestClient) {
        self.client = client
    }

    public func fetchStatus(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .get
        call.path = "/v1/statuses/\(id)"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func getStatusContext(id: String) -> Promise<Context> {
        let call = RestCall<Context>()
        call.method = .get
        call.path = "/v1/statuses/\(id)/context"
        call.params = [
            "id": id,
        ]
        call.serializer = ContextJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func getStatusCard(id: String) -> Promise<Card> {
        let call = RestCall<Card>()
        call.method = .get
        call.path = "/v1/statuses/\(id)/card"
        call.params = [
            "id": id,
        ]
        call.serializer = CardJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func getStatusRebloggedBy(id: String) -> Promise<LinkHeaderList<Account>> {
        let call = RestCall<LinkHeaderList<Account>>()
        call.method = .get
        call.path = "/v1/statuses/\(id)/reblogged_by"
        call.params = [
            "id": id,
        ]
        call.serializer = AccountJsonMapper.singleton.linkHeaderListResponseSerializer
        return client.toPromise(call)
    }

    public func getStatusFavouritedBy(id: String) -> Promise<LinkHeaderList<Account>> {
        let call = RestCall<LinkHeaderList<Account>>()
        call.method = .get
        call.path = "/v1/statuses/\(id)/favourited_by"
        call.params = [
            "id": id,
        ]
        call.serializer = AccountJsonMapper.singleton.linkHeaderListResponseSerializer
        return client.toPromise(call)
    }

    public func postStatus(update: StatusUpdate) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/v1/statuses"
        call.params = [
            "update": update,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func deleteStatus(id: String) -> Promise<Int> {
        let call = RestCall<Int>()
        call.method = .delete
        call.path = "/v1/statuses/\(id)"
        call.params = [
            "id": id,
        ]
        call.serializer = nil
        return client.toPromise(call)
    }

    public func reblogStatus(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/v1/statuses/\(id)/reblog"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func unreblogStatus(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/v1/statuses/\(id)/unreblog"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func favouriteStatus(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/v1/statuses/\(id)/favourite"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    public func unfavouriteStatus(id: String) -> Promise<Status> {
        let call = RestCall<Status>()
        call.method = .post
        call.path = "/v1/statuses/\(id)/unfavourite"
        call.params = [
            "id": id,
        ]
        call.serializer = StatusJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
