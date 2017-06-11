//
// Created by Mariotaku Lee on 2017/6/11.
// Copyright (c) 2017 Mariotaku Dev. All rights reserved.
//

import Foundation

protocol KotlinProtocol {

}

extension KotlinProtocol {
    func also(closure: (_ it: Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: KotlinProtocol {
}