import Foundation

protocol NetworkManagerProtocol {
    func request<T: Codable>(_ req: RequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void)
}
