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
        return self[startIndex.advancedBy(range.startIndex)...startIndex.advancedBy(range.endIndex)]
    }
    
    /// Returns a tuple containing the string made by relpacing in the
    /// `String` all HTML character entity references with the corresponding
    /// character. Also returned is an array of offset information describing
    /// the location and length offsets for each replacement. This allows
    /// for the correct adjust any attributes that may be associated with
    /// with substrings within the `String`
    func decodeHTMLEntitiesWithOffset(offsetHandler: (index: String.Index, utf16Offset: String.Index.Distance) -> Void) -> String {
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(string : String, base : Int32) -> Character? {
            let code = UInt32(strtoul(string, nil, base))
            return Character(UnicodeScalar(code))
        }
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(entity : String) -> Character? {
            if entity.hasPrefix("&#x") || entity.hasPrefix("&#X"){
                return decodeNumeric(entity.substringWithRange(Range<String.Index>(entity.startIndex.advancedBy(3)..<entity.endIndex.advancedBy(-1))), base:16)
                
            } else if entity.hasPrefix("&#") {
                return decodeNumeric(entity.substringWithRange(Range<String.Index>(entity.startIndex.advancedBy(2)..<entity.endIndex.advancedBy(-1))), base:10)
                
            } else {
                return characterEntities[entity]
            }
        }
        // ===== Method starts here =====
        var result = ""
        var position = startIndex
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self.rangeOfString("&", range: position ..< endIndex) {
            result.appendContentsOf(self[position ..< ampRange.startIndex])
            position = ampRange.startIndex
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            if let semiRange = self.rangeOfString(";", range: position ..< endIndex) {
                let entity = self[position ..< semiRange.endIndex]
                if let decoded = decode(entity) {
                    // Replace by decoded character:
                    result.append(decoded)
                    // Record offset
                    offsetHandler(index: semiRange.endIndex, utf16Offset: 1 - entity.utf16.count)
                } else {
                    // Invalid entity, copy verbatim:
                    result.appendContentsOf(entity)
                }
                position = semiRange.endIndex
            } else {
                // No matching ';'.
                break
            }
        }
        // Copy remaining characters to `result`:
        result.appendContentsOf(self[position ..< endIndex])
        // Return results
        return result
    }
}

extension String.UnicodeScalarView {
    func utf16Count(range: Range<String.UnicodeScalarView.Index>) -> Int {
        var count = 0
        for scalar in self[range] {
            UTF16.encode(scalar, output: { unit in
                count+=1
            })
        }
        return count
    }
    
    func utf16Count() -> Int {
        var count = 0
        for scalar in self {
            UTF16.encode(scalar, output: { unit in
                count+=1
            })
        }
        return count
    }
}