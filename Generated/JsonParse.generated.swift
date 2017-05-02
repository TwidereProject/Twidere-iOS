// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

protocol JsonParsable {
    associatedtype T

    static func parse(_ instance: T, parser: PMJacksonParser) -> T

    static func parseField(_ instance: T, _ fieldName: String, _ parser: PMJacksonParser)
}















