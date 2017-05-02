//
//  RestCall.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/2.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class RestCall<T> {
    var method: HTTPMethod = .get
    var path: String!
    
    var headers: [String: String]? = nil
    
    var queries: [String: String?]? = nil
    var params: [String: Any?]? = nil
    
    var serializer: DataResponseSerializer<T>!
    var validation: DataRequest.Validation!
}

extension RestClient {
    
    func toPromise<T>(_ call: RestCall<T>) -> Promise<T> {
        return Promise { fullfill, reject in
            let url = endpoint.constructUrl(call.path, queries: call.queries)
            let handler: (DataResponse<T>) -> Void = { response in
                switch response.result {
                case .success(let value):
                    fullfill(value)
                case .failure(let error):
                    reject(error)
                }
            }
            if let params = call.params, params.contains(where: { $0.1 is Data }) {
                //finalHeaders["Content-Type"] = multipart.contentType
                let finalHeaders = call.headers
                Alamofire.upload(
                    multipartFormData: { multipart in
                        for (k, v) in params {
                            switch v {
                            case let d as Data:
                                multipart.append(d, withName: k, mimeType: "application/octet-stream")
                            default:
                                multipart.append("\(v)".data(using: String.Encoding.utf8)!, withName: k)
                            }
                        }
                }, to: url, method: call.method, headers: finalHeaders,
                   encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case let .success(request, _, _):
                        request.response(responseSerializer: call.serializer, completionHandler: handler)
                    case let .failure(error):
                        reject(error)
                    }
                })
            } else {
                let encoding = URLEncoding.methodDependent
                let request = Alamofire.request(url, method: call.method, parameters: call.params, encoding: encoding, headers: call.headers)
                if (call.validation != nil) {
                    request.validate(call.validation)
                } else {
                    request.validate()
                }
                request.response(responseSerializer: call.serializer, completionHandler: handler)
            }
        }
    }
    
}
