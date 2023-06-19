@testable import desafioDigio

class HomeServiceStub: HomeServiceProtocol {
    var result: Result<HomeModel, AppError>?
    var getDigioHomeProductsCalled = false
    
    func getDigioHomeProducts(completion: @escaping (Result<HomeModel, AppError>) -> Void) {
        getDigioHomeProductsCalled = true
        if let result = result {
            completion(result)
        }
    }
}
