//
//  HtmlBuilder.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2017/5/3.
//  Copyright © 2017年 Mariotaku Dev. All rights reserved.
//

import Foundation

class HtmlBuilder {
    
    private let source: String.UnicodeScalarView
    private let throwExceptions: Bool
    private let sourceIsEscaped: Bool
    private let shouldReEscape: Bool
    
    init(_ source: String.UnicodeScalarView, throwExceptions: Bool, sourceIsEscaped: Bool, shouldReEscape: Bool) {
        self.source = source
        self.throwExceptions = throwExceptions
        self.sourceIsEscaped = sourceIsEscaped
        self.shouldReEscape = shouldReEscape
    }
    
    func buildWithIndices() -> (String, [SpanItem]) {
        return ("", [])
    }
}
