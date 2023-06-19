import Foundation

class HomeService: HomeServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    public init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getDigioHomeProducts(completion: @escaping (Result<HomeModel, AppError>) -> Void) {
        
        networkManager.request(HomeRequest()) { (result: Result<HomeModel, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                switch error {
                case .badURL:
                    completion(.failure(.request))
                case .serverError(let description):
                    print(description)
                    completion(.failure(.server))
                case .badRequest(let code, let description):
                    print(code)
                    print(description)
                    completion(.failure(.request))
                case .invalidJSON(let description):
                    print(description)
                    completion(.failure(.generic))
                case .invalidResponse:
                    completion(.failure(.generic))
                case .connectionError:
                    completion(.failure(.connection))
                }
            }
        }
    }
}
