import Foundation

protocol HomeServiceProtocol {
    func getDigioHomeProducts(completion: @escaping (Result<HomeModel, AppError>) -> Void)
}
