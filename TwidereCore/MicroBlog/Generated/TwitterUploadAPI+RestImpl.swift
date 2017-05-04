// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PromiseKit
import RestClient

internal class TwitterUploadAPIRestImpl: TwitterUploadAPI, RestAPIProtocol {

    let client: RestClient

    required init(client: RestClient) {
        self.client = client
    }

    func initUploadMedia(mediaType: String, totalBytes: Int, additionalOwners: [String]?) -> Promise<MediaUploadResponse> {
        let call = RestCall<MediaUploadResponse>()
        call.method = .post
        call.path = "/media/upload.json"
        call.params = [
            "additional_owners": additionalOwners,
            "command": "INIT",
            "media_type": mediaType,
        ]
        call.serializer = MediaUploadResponseJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    func appendUploadMedia(id: String, segmentIndex: Int, media: Data) -> Promise<Int> {
        let call = RestCall<Int>()
        call.method = .post
        call.path = "/media/upload.json"
        call.params = [
            "media": media,
            "additional_owners": id,
            "command": "APPEND",
            "segment_index": segmentIndex,
        ]
        call.serializer = StatusCodeResponseSerializer
        return client.toPromise(call)
    }

    func finalizeUploadMedia(id: String) -> Promise<MediaUploadResponse> {
        let call = RestCall<MediaUploadResponse>()
        call.method = .post
        call.path = "/media/upload.json"
        call.params = [
            "command": "FINALIZE",
            "media": id,
        ]
        call.serializer = MediaUploadResponseJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

    func getUploadMediaStatus(id: String) -> Promise<MediaUploadResponse> {
        let call = RestCall<MediaUploadResponse>()
        call.method = .post
        call.path = "/media/upload.json"
        call.params = [
            "command": "STATUS",
            "media": id,
        ]
        call.serializer = MediaUploadResponseJsonMapper.singleton.responseSerializer
        return client.toPromise(call)
    }

}
