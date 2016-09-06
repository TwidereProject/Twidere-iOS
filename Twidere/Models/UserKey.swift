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
    
    var string: String  {
        var chars = [Character]()
        escape(id, dest: &chars)
        if (host != nil) {
            chars.append("@")
            escape(host!, dest: &chars)
        }
        return String(chars)
    }
    
    init(rawValue: String) {
        var escaping = false, idFinished = false
        var idBuilder = [Character](), hostBuilder = [Character]()
        
        rawValue.characters.forEach { ch in
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
                    hostBuilder.append(ch)
                } else {
                    idBuilder.append(ch)
                }
            }
        }
        if (hostBuilder.isEmpty) {
            self.id = String(idBuilder)
            self.host = nil
        } else {
            self.id = String(idBuilder)
            self.host = String(hostBuilder)
        }
    }
    
    init(id: String, host: String?) {
        self.id = id
        self.host = host
    }
    
    private func escape(str: String, inout dest: [Character]) {
        str.characters.forEach { ch in
            if (isSpecialChar(ch)) {
                dest.append("\\")
            }
            dest.append(ch)
        }
    }
    
    private func isSpecialChar(ch: Character) -> Bool {
        return ch == "\\" || ch == "@" || ch == ","
    }
}