@testable import desafioDigio

class NetworkManagerStub: NetworkManagerProtocol {
    var requestCalled = false
    var request: RequestProtocol?
    var result: Result<HomeModel, NetworkError>?
    
    func request<T: Decodable>(_ request: RequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) {
        requestCalled = true
        self.request = request
        if let result = result as? Result<T, NetworkError> {
            completion(result)
        }
    }
}
