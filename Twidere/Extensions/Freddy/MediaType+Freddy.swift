//
//  MediaItem+Freddy.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/13.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import Freddy

extension MediaItem.MediaType: JSONDecodable {
    public init(json: JSON) throws {
        guard case let .string(string) = json else {
            throw JSON.Error.valueNotConvertible(value: json, to: MediaItem.MediaType.self)
        }
        guard let type = MediaItem.MediaType(rawValue: string) else {
            throw JSON.Error.valueNotConvertible(value: json, to: MediaItem.MediaType.self)
        }
        self = type
    }
}
