// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

public protocol JsonMappable {
    init()
}

public protocol JsonFieldConverter {
    associatedtype T

    static func parse(_ parser: PMJacksonParser) -> T!

}

public class JsonMapper<T: JsonMappable> {

    public func parse(_ parser: PMJacksonParser) -> T! {
        fatalError("Not implemented")
    }

    public func parseField(_ instance: T, _ fieldName: String, _ parser: PMJacksonParser) {
        // No-op
    }

}






























