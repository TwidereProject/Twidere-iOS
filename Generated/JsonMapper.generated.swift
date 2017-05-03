// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import PMJackson

public protocol JsonMappable {
    init()
}

public class JsonMapper<T: JsonMappable> {

    public func parse(_ parser: PMJacksonParser) -> T! {
        fatalError("Not implemented")
    }

    public func parseField(_ instance: T, _ fieldName: String, _ parser: PMJacksonParser) {
        // No-op
    }

}
















