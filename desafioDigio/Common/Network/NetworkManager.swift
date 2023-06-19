import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    var session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Codable>(_ req: RequestProtocol, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: "\(req.host)\(req.path)") else {
            completion(.failure(.badURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.badRequest(code: httpResponse.statusCode, error: "Bad Request")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.invalidJSON(error.localizedDescription)))
            }
        }.resume()
    }
}
