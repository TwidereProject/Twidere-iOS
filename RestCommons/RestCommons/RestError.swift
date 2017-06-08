public enum RestError: Error {
    case networkError
    case serviceError(errors: [ErrorInfo])
    case requestError(code:Int, message:String?)
    case decodeError
    case argumentError(message: String?)
    
    public struct ErrorInfo {
        let code: Int
        let name: String?
        let message: String
    }
    
}

public extension RestError {
    var errorMessage: String {
        switch self {
        case .networkError:
            return "Network error"
        case .decodeError:
            return "Server returned invalid response"
        case let .serviceError(errors):
            return errors.first!.message
        case let .requestError(code, message):
            // TODO return human readable message
            return "Request error \(code): \(message ?? "nil")"
        default:
            return "Internal error"
        }
    }
}
