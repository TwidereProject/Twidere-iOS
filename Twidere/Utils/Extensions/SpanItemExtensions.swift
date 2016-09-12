//
//  SpanItemExtensions.swift
//  Twidere
//
//  Created by Mariotaku Lee on 16/9/11.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import Foundation

protocol SpanItem {
    var start: Int32 { get set }
    var end: Int32 { get set }
    var origStart: Int32 { get set }
    var origEnd: Int32 { get set }
}

extension LinkSpanItem: SpanItem {}
extension MentionSpanItem: SpanItem {}
extension HashtagSpanItem: SpanItem {}