//
//  UserKey.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

struct UserKey {
    var id: String
    var host: String?
    
    init?(str: String?) {
        if (str == nil) {
            return nil
        }
        var escaping = false, idFinished = false
        var idBuilder = NSMutableString(), hostBuilder = NSMutableString()
        
        str!.characters.forEach { ch in
            var append = false
            if (escaping) {
                // accept all characters if is escaping
                append = true
                escaping = false
            } else if (ch == "\\") {
                escaping = true
            } else if (ch == "@") {
                idFinished = true
            } else if (ch == ",") {
                // end of item, just jump out
                return
            } else {
                append = true
            }
            if (append) {
                if (idFinished) {
                    hostBuilder.appendString("\(ch)")
                } else {
                    idBuilder.appendString("\(ch)")
                }
            }
        }
        if (hostBuilder.length != 0) {
            self.id = idBuilder as String
            self.host = hostBuilder as String
        } else {
            self.id = idBuilder as String
            self.host = nil
        }
    }
    
    init(id: String, host: String?) {
        self.id = id
        self.host = host
    }
}