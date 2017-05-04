//
//  UserKey.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/7/12.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

public struct UserKey: Hashable {
    var id: String
    var host: String?

    public init(id: String, host: String?) {
        self.id = id
        self.host = host
    }
    
    public var hashValue: Int {
        var result = id.hashValue
        result = 31 * result + (host?.hashValue ?? 0)
        return result
    }
}

public func == (l: UserKey, r: UserKey) -> Bool {
    if (l.id != r.id) {
        return false
    }
    return l.host == r.host
}

extension UserKey {
    
    public var string: String  {
        var chars = [Character]()
        escape(id, dest: &chars)
        if (host != nil) {
            chars.append("@")
            escape(host!, dest: &chars)
        }
        return String(chars)
    }
    
    public init(stringLiteral rawValue: String) {
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
            self.init(id: String(idBuilder), host: nil)
        } else {
            self.init(id: String(idBuilder), host: String(hostBuilder))
        }
    }
    
    fileprivate func escape(_ str: String, dest: inout [Character]) {
        str.characters.forEach { ch in
            if (isSpecialChar(ch)) {
                dest.append("\\")
            }
            dest.append(ch)
        }
    }
    
    fileprivate func isSpecialChar(_ ch: Character) -> Bool {
        return ch == "\\" || ch == "@" || ch == ","
    }
    
    public static func arrayFrom(string: String) -> [UserKey] {
        return string.components(separatedBy: ",").map{ UserKey(stringLiteral: $0) }
    }
}

public extension Sequence where Iterator.Element == UserKey {
    
    public var string: String {
        return self.map({ $0.string }).joined(separator: ",")
    }
    
}
