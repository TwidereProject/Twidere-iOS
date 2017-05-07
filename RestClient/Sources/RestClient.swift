//
//  MicroBlogService.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/9.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Alamofire
import PromiseKit

typealias HttpResult = (request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: NSError?)

public class RestClient {
    
    let endpoint: Endpoint
    let auth: Authorization?
    let userAgent: String?
    
    public init(endpoint: Endpoint, auth: Authorization? = nil, userAgent: String? = nil) {
        self.endpoint = endpoint
        self.auth = auth
        self.userAgent = userAgent
    }

}

public protocol RestAPIProtocol {
    
    init(client: RestClient)
    
}
