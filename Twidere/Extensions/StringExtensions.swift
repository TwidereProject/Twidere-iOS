//
//  StringExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/8/27.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation
import StringExtensionHTML

extension String {
    
    subscript(range: Range<Int>) -> String {
        return self[characters.index(startIndex, offsetBy: range.lowerBound)...characters.index(startIndex, offsetBy: range.upperBound)]
    }
    
    /// Returns a tuple containing the string made by relpacing in the
    /// `String` all HTML character entity references with the corresponding
    /// character. Also returned is an array of offset information describing
    /// the location and length offsets for each replacement. This allows
    /// for the correct adjust any attributes that may be associated with
    /// with substrings within the `String`
    func decodeHTMLEntitiesWithOffset(_ offsetHandler: (_ index: String.Index, _ utf16Offset: String.Index.Distance) -> Void) -> String {
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(_ string : String, base : Int32) -> Character? {
            let code = UInt32(strtoul(string, nil, base))
            return Character(UnicodeScalar(code)!)
        }
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(_ entity : String) -> Character? {
            if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
                return decodeNumeric(entity.substring(with: Range<String.Index>(entity.characters.index(entity.startIndex, offsetBy: 3)..<entity.characters.index(entity.endIndex, offsetBy: -1))), base:16)
                
            } else if entity.hasPrefix("&#") {
                return decodeNumeric(entity.substring(with: Range<String.Index>(entity.characters.index(entity.startIndex, offsetBy: 2)..<entity.characters.index(entity.endIndex, offsetBy: -1))), base:10)
                
            } else {
                return characterEntities[entity]
            }
        }
        // ===== Method starts here =====
        var result = ""
        var position = startIndex
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self.range(of: "&", range: position ..< endIndex) {
            result.append(self[position ..< ampRange.lowerBound])
            position = ampRange.lowerBound
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            if let semiRange = self.range(of: ";", range: position ..< endIndex) {
                let entity = self[position ..< semiRange.upperBound]
                if let decoded = decode(entity) {
                    // Replace by decoded character:
                    result.append(decoded)
                    // Record offset
                    offsetHandler(index: semiRange.upperBound, utf16Offset: 1 - entity.utf16.count)
                } else {
                    // Invalid entity, copy verbatim:
                    result.append(entity)
                }
                position = semiRange.upperBound
            } else {
                // No matching ';'.
                break
            }
        }
        // Copy remaining characters to `result`:
        result.append(self[position ..< endIndex])
        // Return results
        return result
    }
}

extension String.UnicodeScalarView {
    func utf16Count(_ range: Range<String.UnicodeScalarView.Index>) -> Int {
        var count = 0
        for scalar in self[range] {
            UTF16.encode(scalar, into: { unit in
                count+=1
            })
        }
        return count
    }
    
    func utf16Count() -> Int {
        var count = 0
        for scalar in self {
            UTF16.encode(scalar, into: { unit in
                count+=1
            })
        }
        return count
    }
}
