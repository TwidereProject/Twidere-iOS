//
//  JsonMapperExtension.swift
//  TwidereCore
//
//  Created by Mariotaku Lee on 2017/5/5.
//  Copyright © 2017年 Mariotaku Lee. All rights reserved.
//

import PMJackson
import PMJSON

extension JsonMapper where T: JsonMappable {
    
    func parse(json: String) -> T! {
        guard let data = json.data(using: .utf8) else {
            return nil
        }
        let options = JSONParserOptions(strict: false, useDecimals: false, streaming: true)
        return parse(JsonParser(JSON.parser(for: data, options: options)))
    }
    
}
