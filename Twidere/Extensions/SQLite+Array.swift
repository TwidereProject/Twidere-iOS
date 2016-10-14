//
//  SQLite+Array.swift
//  Twidere
//
//  Created by Mariotaku Lee on 2016/10/14.
//  Copyright © 2016年 Mariotaku Dev. All rights reserved.
//

import SQLite

extension Row {
    func get<V: ArrayValue>(_ column: Expression<[V]?>) -> [V]? {
        guard let datatypeValue = self.get(Expression<String?>(column.template)) else {
            return nil
        }
        guard let array = V.arrayFromDatatypeValue(datatypeValue) else {
            return nil
        }
        return array.map {item in return item as! V}
    }
}

extension TableBuilder {
    
    func column<V : ArrayValue>(_ name: Expression<[V]>, unique: Bool = false, check: Expression<Bool>? = nil, defaultValue: Expression<[V]>? = nil) {
        let name: Expression<String> = name.wrapped()
        let defaultValue: Expression<String>? = defaultValue?.wrapped()
        self.column(name, unique: unique, check: check, defaultValue: defaultValue)
    }
    
    func column<V : ArrayValue>(_ name: Expression<[V]?>, unique: Bool = false, check: Expression<Bool>? = nil, defaultValue: Expression<[V]>? = nil) {
        let name: Expression<String> = name.wrapped()
        let defaultValue: Expression<String>? = defaultValue?.wrapped()
        self.column(name, unique: unique, check: check, defaultValue: defaultValue)
    }
    
}


func <-<V : ArrayValue>(column: Expression<[V]?>, value: [V]?) -> Setter {
    let column: Expression<String?> = column.wrapped()
    guard let value: [V] = value else {
        return column <- nil
    }
    return column <- V.arrayToDatatypeValue(array: value.map{ $0 as! V.ArrayValueType })
}

extension Expression {
    func wrapped<T>() -> Expression<T> {
        return Expression<T>(template, bindings)
    }
}

protocol ArrayValue {
    
    associatedtype ArrayValueType = Self
    
    static func arrayFromDatatypeValue(_ datatypeValue: String) -> [ArrayValueType]?
    
    static func arrayToDatatypeValue(array: [ArrayValueType]) -> String
}
