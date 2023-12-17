import Foundation

public enum NetworkError: Error {
        case urlSessionError
        case urlRequstError(Error)
        case httpStatusCode(Int)
        case other(NSError)
        case decodingError(Error)
        case noInternetConnection
        case inavalidRequest
    }
