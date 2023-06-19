import Foundation

protocol HomeAdapterProtocol {
    func prepareHomeViewModel(with homeModel: HomeModel) -> HomeViewModel
}
