import Foundation

public enum NetworkError: Error, Equatable {
    case badURL
    case serverError(String)
    case badRequest(code: Int, error: String)
    case invalidJSON(String)
    case invalidResponse
    case connectionError
}
